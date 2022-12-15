with open("../RTL/CPU/out.txt", "r") as f:
  hit = miss = access = 0
  line = f.readline()
  while line:
    if "hit" in line:
      hit += 1
      access += 1
    elif "Miss" in line:
      miss += 1
      access += 1
    line = f.readline()

print("In total there were", str(hit), "hits and", str(miss), "misses. Total memory accesses were", str(access) + ". For a hitrate of", str(round(hit/(miss+hit), 4) * 100) + "%.")