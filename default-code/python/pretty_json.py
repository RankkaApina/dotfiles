from APdefs import *
import os

if __name__=='__main__':

  infile=os.path.expandvars(os.sys.argv[1])
  if (len(os.sys.argv) > 1):
    outfile=os.path.expandvars(os.sys.argv[2])
  else:
    outfile=infile

  pretty_json(infile, outfile)