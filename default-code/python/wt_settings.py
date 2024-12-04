import json
import os
from collections.abc import Mapping

def wt_update(orig_dict, new_dict, profile_order):
  for key, val in new_dict.items():
    if key not in orig_dict:
      orig_dict[key] = val
    elif isinstance(val, Mapping):
      # If the value is a dictionary, call wt_update recursively
      orig_dict[key] = wt_update(orig_dict.get(key, { }), val, profile_order)
    elif isinstance(val, list):
      if key == "actions":
        # For 'actions', you just append items from new_dict
        for item in val:
          orig_dict[key].append(item)
      else:
        for item in val:
          
          queen_key = "name"   

          # Ensure item is a dictionary and contains the necessary key
          if isinstance(item, dict) and queen_key in item:
            # Check if item already exists in orig_dict's list
            existing_item = next((d for d in orig_dict[key] if d.get(queen_key) == item[queen_key]), None)
            if existing_item:
              # Update the existing item
              wt_update(existing_item, item, profile_order)
            else:
              # Append the new item
              orig_dict[key].append(item)
      if key == "list":
        orig_dict[key].sort(key=lambda x: profile_order[x["name"]])
    else:
      # If it's not a dict or list, just replace the value
      orig_dict[key] = val
  
  return orig_dict   


def merge_wt(file_list, input_path, output_file, profile_order):
  input_files = []
  with open(file_list) as flist:
    for line in flist:
      f = os.path.join(input_path, line).strip()
      input_files.append(f)
  
  merged = {}
  for file in input_files:
    with open(file, 'r') as json_file:
      merged = wt_update(merged, json.load(json_file), profile_order)
  
  #print(merged["profiles"]["list"])

  with open(output_file, 'w+') as of:
    json.dump(merged, of, indent=2)


if __name__=='__main__':

  file_list=os.path.expandvars(os.sys.argv[1])
  input_path=os.path.expandvars(os.sys.argv[2])
  output_file=os.path.expandvars(os.sys.argv[3])

  profile_order={'Debian':0, 'Windows PowerShell':1, 'Command Prompt':2, 'Azure Cloud Shell':3}
  
  merge_wt(file_list, input_path, output_file, profile_order)
