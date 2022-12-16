- [**Useful information**](#useful-information)
- [**Table of tasks for single-cycle CPU**](#table-of-tasks-for-single-cycle-cpu)
- [**Useful information**](#useful-information-1)
- [**Table of tasks for single-cycle CPU**](#table-of-tasks-for-single-cycle-cpu-1)
- [**Explanation and testing of our selected programs**](#explanation-and-testing-of-our-selected-programs)
  - [PDF assembly:](#pdf-assembly)
  - [F1 assembly:](#f1-assembly)
- [**Explanation and testing of our selected programs**](#explanation-and-testing-of-our-selected-programs-1)
  - [PDF assembly:](#pdf-assembly-1)
  - [F1 assembly:](#f1-assembly-1)

## **Useful information**

* For more detailed information about the implementation of the software and hardware in the pipelined CPU please see the README in the [root folder](https://github.com/EIE2-IAC-Labs/iac-riscv-cw-5/tree/pipeline#implementation)
* We had to add 4 new registers in order to implement a pipelined CPU. These new components are in the RTL folder. Apart from that new control signals have been implemented [explained here](https://github.com/EIE2-IAC-Labs/iac-riscv-cw-5/tree/pipeline#addition-of-control-signals--logic). Otherwise no major changes had to be made in the other components. 
---
## **Table of tasks for single-cycle CPU**


- [**Useful information**](#useful-information)
- [**Table of tasks for single-cycle CPU**](#table-of-tasks-for-single-cycle-cpu)
- [**Useful information**](#useful-information-1)
- [**Table of tasks for single-cycle CPU**](#table-of-tasks-for-single-cycle-cpu-1)
- [**Explanation and testing of our selected programs**](#explanation-and-testing-of-our-selected-programs)
  - [PDF assembly:](#pdf-assembly)
  - [F1 assembly:](#f1-assembly)
- [**Explanation and testing of our selected programs**](#explanation-and-testing-of-our-selected-programs-1)
  - [PDF assembly:](#pdf-assembly-1)
  - [F1 assembly:](#f1-assembly-1)

## **Useful information**

* For more detailed information about the implementation of the software and hardware in the cached CPU please see the README in the [root folder](https://github.com/EIE2-IAC-Labs/iac-riscv-cw-5/tree/cache)

---
## **Table of tasks for single-cycle CPU**


| Module / Team members   	| Luigi 	| Diego 	| Corey 	| Ezra 	|
|-------------------------	|-------	|-------	|-------	|------	|
| Design, Build, Test     	| M     	| M     	| M     	|      	|
| Hit / Miss              	|       	| M     	|       	|      	|
| Think and Conceptualise 	| C     	| C     	| C     	| C    	|


---
## **Explanation and testing of our selected programs**

### PDF assembly: 
The [program purpose](https://github.com/EIE2-IAC-Labs/iac-riscv-cw-5/tree/develop#explanation-and-testing-of-our-selected-programs)  is the same as the one described in the single-cycle CPU. However `nop` have been added. [Click here](https://github.com/EIE2-IAC-Labs/iac-riscv-cw-5/tree/pipeline#software-design) for a more detailed explanation. 

To use the *run.sh*: 
1. Have vbuddy.cfg in the CPU directory 
2. `cd /RTL` 
```bash 
source ./run.sh pdf pdf_tb gaussian

```

### F1 assembly: 

To use *run.sh*:
1. Have vbuddy.cfg in the CPU directory 
2. `cd /RTL` 
```bash 
source ./run.sh F1_asm F1_tb

```


---
## **Explanation and testing of our selected programs**

### PDF assembly: 
The [program purpose](https://github.com/EIE2-IAC-Labs/iac-riscv-cw-5/tree/develop#explanation-and-testing-of-our-selected-programs)  is the same as the one described in the single-cycle CPU. However `nop` have been added. [Click here](https://github.com/EIE2-IAC-Labs/iac-riscv-cw-5/tree/pipeline#software-design) for a more detailed explanation. 

To use the *run.sh*: 
1. Have vbuddy.cfg in the CPU directory 
2. `cd /RTL` 
```bash 
source ./run.sh pdf pdf_tb gaussian

```

### F1 assembly: 
The [program purpose](https://github.com/EZePiZy/RISC-V-CPU/tree/develop#f1-assembly-basic) is the same as the one described in the single-cycle CPU. However `nop` have been added. [Click here](https://github.com/EIE2-IAC-Labs/iac-riscv-cw-5/tree/pipeline#software-design) 

To use *run.sh*:
1. Have vbuddy.cfg in the CPU directory 
2. `cd /RTL` 
```bash 
source ./run.sh F1_asm F1_tb

```
