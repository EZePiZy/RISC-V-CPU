# take byte formatted mem file and convert it to 32 bit words

with open("wrong.mem", "r") as f:
  with open("right.mem", "w") as o:
    line = f.readline()
    while line:
      line = line.strip()
      output_line = ""
      vals = line.split(" ")
      print(vals)
      for i in range(len(vals) // 4):
        for j in range(4):
          output_line += format(vals.pop(0), "02")
        output_line += '\n'
      o.write(output_line)
      
      line = f.readline()

