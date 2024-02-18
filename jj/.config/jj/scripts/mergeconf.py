import tomllib
import itertools
import collections
import sys

def deepmerge(dict1, dict2):
  ret = {}
  # Update keys only in dict1 or shared between dict1 and dict2.
  for k, v in dict1.items():
    if not k in dict2:
      ret[k] = v
    elif isinstance(v, collections.abc.MutableMapping):
      # Recursively update mapping values.
      ret[k] = deepmerge(v, dict2[k])
    else:
      # Update flat values.
      ret[k] = dict2[k]
  # Update keys only in dict2.
  for k, v in dict2.items():
    if not k in ret:
      ret[k] = v
  return ret

def dict_to_flat_toml(d):
  lines = []
  frontiers = {f'"{k}"': v for k, v in d.items()}
  while frontiers:
    # Expand dicts/tables for later iterations.
    new_frontiers = dict(itertools.chain.from_iterable(
      [ (f'{k}."{subk}"', subv) for subk, subv in v.items() ]
      for k, v in frontiers.items()
      if isinstance(v, collections.abc.Mapping)))
    # Collect flat values.
    lines.extend(f'{k} = {repr(v)}'
                 for k, v in frontiers.items()
                 if not isinstance(v, collections.abc.Mapping))
    frontiers = new_frontiers
  return '\n'.join(lines)

def main(args):
  filepaths = args[1:]  # `args[0]` is this script itself.
  data = {}
  for filepath in filepaths:
    with open(filepath, "rb") as f:
      data = deepmerge(data, tomllib.load(f))
  print(dict_to_flat_toml(data))

if __name__ == '__main__':
  main(sys.argv)
