Labo HTTP Infra
===============

Ce fichier contiente le rapport et le détails de chaque features implémentées lors de ce labo.
Il a été réalisé par Maxim Golay.

Accès aux différentes étapes
----------------------------

Les 5 étapes principales et obligatoires du labo sont accessibles via des tags `stepX`
sur le dépôt Github, où `X` est un nombre. **VEUILLEZ NOTER** que ce rapport ne sera pas
disponible dans les versions qui ont été taggées, et donc il est recommandé d'en garder une
copie à portée de main pour pouvoir naviguer plus facilement dans le projet.

Description des étapes
----------------------

Les différentes étapes à réalisé sont décrites ici avec la configuration et les changements occasionnés par celles-ci. Pour chaque étape, un fichier `run.sh` et `build.sh` sont proposés
dans les différents sous-dossiers contenant les sources des container dockers.

*Note: À chaque étape, il est possible qu'un fichier README.md se trouve dans le dossier
concernant la feature à implémenter. Il contient des notes sur les détails d'implémentation.
Leur but étant principalement de servir de notes personnelles, il est recommandé de se baser
sur cette documentation plutôt que ces notes.*

### Étape 1

On peut retrouver le contenu pour cette étape dans le dossier `static_server`.
Il s'agissait de réaliser un serveur fixe dockerisé. Ce serveur utilise les configurations
de base de l'image `php-apache:5.6`. Le container docker map le port 80 au port 8080
à son hôte. Le contenu est celui du sous-dossier `src`.

### Étape 2

Le contenu de cette étape se trouve sous le dossier `dynamic_content`.
L'étape deux ajoute un nouveau container, basé sur node.js, qui utilise la librairie
express.js pour générer un payload JSON d'une personne sur le port 80. Ce port
est mappé à l'hôte sur le port 8081.

Le contenu dans le sous-dossier `/src` est l'application en elle-même.
***Avant de déployer le container, il faut y faire un `npm install`*** pour télécharger
les dépendances nécessaire au fonctionnement de l'applet.


### Étape 3

On retrouve le contenu de cette étape dans `reverse_proxy`. Ici, on vient
cacher les 2 containers précédemment exposés derrière un 3ème container qui se charge
de router le traffic. Ce container est basé sur l'image `php-apache:7.2` et map le port
80 interne au port 8080 de l'hôte.

2 configurations sont utilisées dans ce container, qu'on retrouve dans le dossier `conf`.
`001-reverse-proxy.conf` n'accepte que les requêtes à destination de `http-infra.api`.
Celles à destinations de `/api/` sont redirigées au serveur dynamique, les autres
sont envoyées au serveur statique.
`000-sinkhole.conf` est le comportement par défaut qui ignore toutes autres requêtes.

Pour démarrer l'infrastructure, il faut commencer par démarrer manuellement le serveur
statique, puis le serveur dynamique et enfin le reverse proxy, faute de quoi les requêtes
seront redirigées au mauvais endroit par le reverse proxy.


### Étape 4

Ici, on vient ajouter au frontend la capacité d'aller chercher et afficher les informations
retournées par le serveur express.js. On vient faire une requête simple pour obtenir un payload
JSON, puis on affiche ce payload sur la page d'accueil. On utilise aussi JQuery pour ce faire.

Dans les sources du serveur statique, on peut retrouver un fichier `people.js` qui, au chargement
de la page, va fetcher le JSON du serveur dynamique et l'affiche sur la page d'accueil.
Ce fichier utilise aussi la fonction qui va fetcher le JSON comme callback qui est rejoué
après un certains interval de temps fixe.


### Étape 5

Dans cette dernière étape, on vient améliorer la flexibilité du reverse proxy en permettant
de passer des variables d'environnement au container. Ces variables d'environnement, à savoir
`STATIC_ADDR` et `DYNAMIC_ADDR`, ont la forme `IP:PORT`. Le script `run.sh` du reverse proxy
est adapté pour prendre 2 paramètres qui sont les valeurs pour `STATIC_ADDR` et `DYNAMIC_ADDR`,
dans cet ordre.

L'implémentation en détail consiste à changer 2 choses par rapport à l'étape 3:
- Ajout d'un template pour la configuration `001-reverse-proxy.conf`, nommé
`001-reverse-proxy-template.php`, que l'on retrouve dans les dossiers de configurations du container.
- Ajout d'un script d'initialisation, `envsetup.sh`, exécuté au lancement du container
avant apache qui utilise le fichier de template pour créer le vrai fichier de configuration.

À la construction de l'image, le fichier `envsetup.sh` est déplacé à `/usr/local/bin/`
et le template de configuration à `/etc/apache2/templates/`. `envsetup.sh`, au démarrage d'un
container, est exécuté et crée le fichier de config `001-reverse-proxy.conf` en utilisant PHP.
PHP utilise les variables d'environnement reçue et les injecte dans le fichier de configuration 
final qui sera placé dans le dossier `sites_available` d'apache et activé.


Bonus et autres features
------------------------

Les autres fonctionnalités ajoutées peuvent être retrouvée dans le dernier commit de la
branche `master`. Les différents ajouts/changements sont listés ci-après.


### Déploiement de l'application

L'application utilise désormais docker-compose pour orchestrer son démarrage. À la racine du
projet, tapper `docker compose up` démarre tous les containers et met en service l'application.


### Changement de reverse proxy

Pour faciliter la mise en oeuvre de fonctionnalités bonus, l'ancien reverse proxy à été
remplacé par Traefik. Ce nouveau container est construit d'après la dernière image du même
nom sur docker hub.

Traefik utilise 2 configurations: une dite *statique* et une autre dite *dynamique*.
La configuration *statique* peut être trouvée dans le sous-dossier `traefik_proxy/traefik.yml`.
La configuration *dynamique* est, quant à elle, complètement déterminée d'après les `labels`
appliqués au différents container dans le fichier `docker-compose.yml` à la racine du projet.

**LE MAPPAGE DE PORT DE CE CONTAINER EST 80:80 EN LIEU ET PLACE DE 8080:80 PRÉCÉDEMMENT.**
Les mêmes redirections sont mise en place que celles mentionnées dans l'étape 3.

La configuration de Traefik pour imiter le comportement mis en place dans l'étape 3
ne sera pas détaillé ici. On se contentera de rediriger le lecteur à la [documentation
officielle de Traefik](https://doc.traefik.io/traefik/).

### Monitoring reverse proxy

Il est possible d'accéder, aussi via le port 80, au dashboard de Traefik en utilisant le nom
d'hôte `traefik.http-infra.api`. Il permet notamment de voir toute la configuration de Traefik
et tous les containers qui ont été automatiquement détectés et load-balancés.


### Load-balancing du serveur dynamique

Le serveur dynamique peut facilement être load-balancé en Round-Robin tout simplement
en démarrant 2 instances avec la commande `docker compose up --scale dynamic_content=2`.
Traefik détecte automatiquement les 2 instances et applique le load-balancing pour nous.

Pour démontrer facilement le fonctionnement du load-balancing, un GUID généré par chaque
serveur est affiché par le frontend.
