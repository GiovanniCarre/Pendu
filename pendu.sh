#!/bin/bash

# Liste de mots pour le jeu
mots=("PROGRAMMATION" "BASH" "PYTHON" "LINUX" "GITHUB" "DEVELOPPEUR" "TERMINAL")

# Choisir un mot aléatoire
mot_choisi=${mots[RANDOM % ${#mots[@]}]}

# Initialiser les variables
mot_masque=""
tentatives_max=7
tentatives_restantes=$tentatives_max
lettres_utilisees=""

# Fonction pour afficher le mot masqué
afficher_mot() {
    for ((i = 0; i < ${#mot_choisi}; i++)); do
        lettre=${mot_choisi:$i:1}
        if [[ $lettres_utilisees == *$lettre* ]]; then
            echo -n "$lettre "
        else
            echo -n "_ "
        fi
    done
    echo
}

# Fonction principale du jeu
jouer_pendu() {
    clear
    echo "Bienvenue dans le jeu du pendu!"
    
    while [ $tentatives_restantes -gt 0 ]; do
        echo -e "\nMot à deviner :"
        afficher_mot
        
        echo -e "\nLettres utilisées : $lettres_utilisees"
        echo "Tentatives restantes : $tentatives_restantes"
        
        read -p "Entrez une lettre : " lettre

        if [[ ! $lettre =~ [a-zA-Z] ]]; then
            echo "Veuillez entrer une lettre valide."
            continue
        fi

        if [[ $lettres_utilisees == *$lettre* ]]; then
            echo "Vous avez déjà utilisé cette lettre. Essayez une autre."
            continue
        fi

        lettres_utilisees+=$lettre

        if [[ $mot_choisi != *$lettre* ]]; then
            let "tentatives_restantes--"
        fi

        mot_trouve=true
        for ((i = 0; i < ${#mot_choisi}; i++)); do
            lettre=${mot_choisi:$i:1}
            if [[ $lettres_utilisees != *$lettre* ]]; then
                mot_trouve=false
                break
            fi
        done

        if $mot_trouve; then
            clear
            afficher_mot
            echo -e "\nFélicitations! Vous avez deviné le mot ($mot_choisi)!"
            exit
        fi
    done

    clear
    echo "Désolé, vous avez épuisé toutes vos tentatives. Le mot était : $mot_choisi"
}

# Lancer le jeu
jouer_pendu
