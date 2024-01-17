import random
import csv
import pathlib
import os
import pprint


def rand_ints_nodup(a, b, k):
  ns = []
  while len(ns) < k:
    n = random.randint(a, b)
#    print("==> {:03d}".format(n))
    if not n in ns:
      ns.append(n)
  return ns

def write_csv(fn_master, fn_trans, list_data):
    if list_data:
        with open(fn_trans, "w", newline="") as f1:
            fieldnames = [k for k in list_data[0]]
            dict_writer = csv.DictWriter(f1, fieldnames=fieldnames)
            dict_writer.writeheader()
            dict_writer.writerows(list_data)
        write_csv_add(fn_master, list_data)
        '''
        if os.path.isfile(fn_master):
            with open(fn_master, "a", newline="") as f1:
                fieldnames = [k for k in list_data[0]]
                dict_writer = csv.DictWriter(f1, fieldnames=fieldnames)
                if os.path.getsize(fn_master) > 0:
                    pass
                else:
                    dict_writer.writeheader()
                dict_writer.writerows(list_data)
        else:
            with open(fn_master, "w", newline="") as f1:
                fieldnames = [k for k in list_data[0]]
                dict_writer = csv.DictWriter(f1, fieldnames=fieldnames)
                dict_writer.writeheader()
                dict_writer.writerows(list_data)
        '''
    else:
        pathlib.Path(fn_master).touch()

def write_csv_add(fn, list_data):
    if list_data:
        if os.path.isfile(fn):
            write_csv_appendwrite(fn, list_data)
        else:
            write_csv_overwrite(fn, list_data)

def write_csv_appendwrite(fn, list_data):
    with open(fn, "a", newline="") as f1:
        fieldnames = [k for k in list_data[0]]
        dict_writer = csv.DictWriter(f1, fieldnames=fieldnames)
        if os.path.getsize(fn) > 0:
            pass
        else:
            dict_writer.writeheader()
        dict_writer.writerows(list_data)

def write_csv_overwrite(fn, list_data):
    if list_data:
        with open(fn, "w", newline="") as f1:
            fieldnames = [k for k in list_data[0]]
            dict_writer = csv.DictWriter(f1, fieldnames=fieldnames)
            dict_writer.writeheader()
            dict_writer.writerows(list_data)
