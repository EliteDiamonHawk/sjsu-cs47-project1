### Calculator
- a simple calculator created using MIPS Assembly to practice assembly coding for sjsu cs47

## Group Notes
- maybe create branches for each new implementation
- be careful about pushing to main if you don't create a branch
- no overflow is necessary (option implementation)
- maybe no decimal/fractions?
- maybe output the process? to show progression
- general rule: if you push to stack to procedure, you must pop it out at the end. recommended to use push/pop macro/procedure

## Todos
# general checklist
check here | section/about | notes
| main | ask for equation from user, call parser, return answer
| string parser | converts string to number values and function calls
| parenthesis | maybe treats inner values as a whole separate equation, doing a recursive call. maybe delegate to string parser
| exponents | support both base^expo and base^(expo). maybe delegate to string parser
| multiplication |
| division |
| addition |
| subtraction |

# string parser
check here | requirement/condition
| support ()^*x/+-0-9
| support neg/pos numbers
| properly converts ascii numbers to workable numbers in two complement
| input type: string
| output type: value
