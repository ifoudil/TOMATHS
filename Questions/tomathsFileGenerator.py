# Exemple de script qui permet de generer un fichier TOMATHS
import random
with open("tablesMultiplication.txt", "w") as f:
    for i in range(1,11):
        for j in range (1,11):
            f.write(f"{i}x{j},{i*j}\n")