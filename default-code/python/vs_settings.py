import json
import os
from APdefs import *

def merge_vs(file_list, input_path, output_file):
  input_files = []
  with open(file_list) as flist:
    for line in flist:
      f = os.path.join(input_path, line).strip()
      input_files.append(f)
  
  merged = {}
  for file in input_files:
    sort_json(file, file)
    with open(file, 'r') as json_file:
      merged.update(json.load(json_file))

  with open(output_file, 'w+') as of:
    json.dump(merged, of, indent=2, sort_keys=True)


if __name__=='__main__':

  file_list=os.path.expandvars(os.sys.argv[1])
  input_path=os.path.expandvars(os.sys.argv[2])
  output_file=os.path.expandvars(os.sys.argv[3])
  
  merge_vs(file_list, input_path, output_file)
