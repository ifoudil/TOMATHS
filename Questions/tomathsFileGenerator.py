# Exemple de script qui permet de generer un fichier TOMATHS
from sympy import symbols, Eq, solve
import random

with open("Superieur/binaireSimple.txt", "w") as f:
    for i in range (1,12):
        f.write(f"{str(bin(i))[2:]},{i}\n")



""" 
rappels sympy 

from sympy import symbols, Eq, solve

x = symbols('x')
with open("College/equationsAffines.txt", "w") as f:
    for i in range(1,11):
        for j in range (1,11):
            expr = i*x+j
            sol = solve(expr)
            f.write(f"{i}x+{j},{sol[0]}\n")



# Définir la variable symbolique x
x = symbols('x')

with open("Lycee/secondDegre.txt", "w") as f:
    for k in range(1,21):
        for i in range(1,21):
            for j in range (1,21):
                eq1 = Eq(k*x**2 - i*x + j, 0)
                sol = solve(eq1, x)
                if(len(sol)==1 and (sol[0]==-1 or sol[0]==1 or sol[0]==0 or sol[0]==-2 or sol[0]==2)):
                    f.write(f"{k}x^2-{i}x+{j},{sol[0]}\n")
# Résoudre l'équation
"""