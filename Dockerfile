# Image de base
FROM mariadb:11.8.3

# Mot de passe ROOT du serveur de base de données
ENV MARIADB_ROOT_PASSWORD=azer
# Nom de la base de données qui sera créée au 1er démarrage du conteneur
ENV MARIADB_DATABASE=db_employe_service
# Nom d'utilisateur pour se connecter à la base de données
ENV MARIADB_USER=caro
# Mot de passe pour se connecter à la base de données
ENV MARIADB_PASSWORD=12345
