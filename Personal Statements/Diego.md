# <center>**Diego Van Overberghe — CID 02030354**</center>

---

- [**Diego Van Overberghe — CID 02030354**](#diego-van-overberghe--cid-02030354)
  - [What I Contributed to](#what-i-contributed-to)
    - [Single Cycle CPU](#single-cycle-cpu)
    - [Pipeline](#pipeline)
    - [Cache](#cache)
  - [What I Learned](#what-i-learned)
  - [Mistakes I Made](#mistakes-i-made)
  - [What I Would do Differently](#what-i-would-do-differently)

---

## What I Contributed to

- Organising the repository, policy decisions such as protecting branches, [implementing an appropriate `.gitignore`](https://github.com/EIE2-IAC-Labs/iac-riscv-cw-5/commit/63c71177dd274df7ab3d64315869a3c3b1bfde33), [organising directory structure](https://github.com/EIE2-IAC-Labs/iac-riscv-cw-5/commit/da4371ecdb969afde86fea41594bba1b0ccb80f2)
- [run.sh](https://github.com/EIE2-IAC-Labs/iac-riscv-cw-5/commit/cfafb8c04a728ed60be5c293269c9a08e056b3e1)
- [GitHub actions](https://github.com/EIE2-IAC-Labs/iac-riscv-cw-5/commit/405ea281ce13e1b5627f38d2f7fae8fa93e35e6f)

### Single Cycle CPU

- [Designed and implemented the `regfile` and `ALU`](https://github.com/EIE2-IAC-Labs/iac-riscv-cw-5/commit/4151652327386bf497e930a38bb2da804a49d8f1)
- Putting the CPU together and debugging with the team: [1](https://github.com/EIE2-IAC-Labs/iac-riscv-cw-5/commit/ec4a41b4440554e8d3296cb591a8459aebf13f5e), [2](https://github.com/EIE2-IAC-Labs/iac-riscv-cw-5/commit/47b028d2714b307fa919ab433264e7f28ff01240) and [3](https://github.com/EIE2-IAC-Labs/iac-riscv-cw-5/commit/2e8868cba408d528b1612f0e013a86506f383ba9)
- Testing the PDF program, debugging and realising we had wrong memory format: [1](https://github.com/EIE2-IAC-Labs/iac-riscv-cw-5/commit/ae3e19701e73dfc42c71ce2908feb73c4e1d0572) and [2](https://github.com/EIE2-IAC-Labs/iac-riscv-cw-5/commit/d2b2dd19e722485a5b0a1efadd719c87f07613be)
- [Fix the one liner](https://github.com/EIE2-IAC-Labs/iac-riscv-cw-5/commit/076dcae4ecf50d1cd1e816a8db3c9745dad47b6a)

### Pipeline

- Optimising the `PDF.s` program by removing redundant NOPs: [1](https://github.com/EIE2-IAC-Labs/iac-riscv-cw-5/commit/cb9364e620e56d51200953e202080b63f1f18fe8)
- [Diagnose and resolve `jalr` issue alongside the team ](https://github.com/EIE2-IAC-Labs/iac-riscv-cw-5/commit/358858bc7fd33fd36d0927ef62484d371ecda2f5)
- [Providing a delayed instruction word at every stage in the pipeline to assist with debugging](https://github.com/EIE2-IAC-Labs/iac-riscv-cw-5/commit/ba1ca108f9131a9dd315cbe93c142ba358419274)
- [Testing `pdf.s` program with pipelined CPU](https://github.com/EIE2-IAC-Labs/iac-riscv-cw-5/commit/778077901a5367e21a1e67f95669b2bb9b390c64)

### Cache

- [cache design and implementation](https://github.com/EIE2-IAC-Labs/iac-riscv-cw-5/commit/d25bd4a70e8f78e2cdf81bec459ce508c7d4db12)
- [cache and ram activation for hitrate calculation](https://github.com/EIE2-IAC-Labs/iac-riscv-cw-5/commit/5f0baa7652e50f659d62eadf317fea3ea65bee76)

## What I Learned

I believe that this kind of project is crucial for this module. The labs have been particularly helpful in consolidating the vast amount of theoretical knowledge we have accrued. The ability to have time allocated to come together as a team and create a CPU with a real instruction set has been a fantastic opportunity to put into application what I have learnt, but also correct misunderstandings I may have had, with my peers showing me how to improve. I hope that I have also been able to help my peers as they have helped me.

I felt that the learning curve was not too steep, and that most wasted time was due to small errors that were hard to find because of the nature of hardware debugging. This clearly showed me how important it is when working as a team to make your code easy to understand, particularly by others. I have not had many opportunities to work as a team on a project of this scale. In the past, I have struggled opening my code to others, because I did not like the feeling of being unfamiliar with code that has appeared within my own code. I have really come to appreciate the following quote Software Engineer Martin Fowler:

    "Any fool can write code that a computer can understand. Good programmers write code that humans can understand."

I believe that as we worked together on the project, we managed to write better and better code in this regard.

Of course, I have also learnt alot about SystemVerilog. When I started this module earlier in the year, I had no experience in any HDL, and feel that the CPU project has allowed me to much better understand the RISC-V instruction set and its parculiarities such as the various immediate formats.

I have been using git for many years and as is the case every time I have a project using git, I learn more and more. Most of my time using git has been on solo projects. I am quite annoying when it comes to the look of a repository, so for example had to setup git correctly on my teammate's computers to, for example, rebase when they commited without pulling first. This isn't an issue on solo project repositories because no-one is commiting other than you. In this environment where others might have committed since you last pushed, rebasing instead of merging to resolve the issue keeps linear history where branching is used. I feel that I have learnt better ways to teach others about using git and helping git do what you need it to do.

Further to the above, I was able to setup a GitHub action to keep the "official" repository up to date with the repository we were actually committing to (owned by Ezra). The reason we had to this was because we made our original repository before the offical ones were issued, and already had started using issues, branch protection and projects in this repository. Additionally, branch protection is only available for private repositories owned by either users or organisations with GitHub Pro. The EIE2-IAC-Labs organisation does not have such a subscription so to keep branch protection (where contributors have to make a pull request which has to be approved by a certain number of others). I think that the branch protection was a good feature to use because it meant that teammates could keep on top of what others were adding.

## Mistakes I Made

Overall, the mistakes that I made were mostly small errors or quirks with verilator and SystemVerilog such as the fact that `readmem` doesn't read the last line if there is not newline at the end of the file.

An example of this could be any of the various commits intitled `fix: ***`, such as [this one](https://github.com/EIE2-IAC-Labs/iac-riscv-cw-5/commit/0e29bc6e60e460e7b21bd30639b4080c1bec708f), or one where I accidentally made `run.sh` delete the `vbuddy.cfg` file every time it was run, to the intense annoyance of my partners. See that commit [here](https://github.com/EIE2-IAC-Labs/iac-riscv-cw-5/commit/f567edb8454838afc62914d29c2c66bb411ede16).

## What I Would do Differently

Overall, I believe we worked extremely well as a team, and am very happy with what we managed to produce in such a short time. If I were to do it again, the only things I would change would be due to insights I gained by learning about SystemVerilog and the ISA, such as using the TYPES from the beginning to make my code clearer.