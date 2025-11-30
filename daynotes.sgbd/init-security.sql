-- Supprimer les utilisateurs root distants (garder seulement localhost)
DELETE FROM mysql.user WHERE user='root' AND host != 'localhost';

-- Supprimer les utilisateurs anonymes
DELETE FROM mysql.user WHERE user='';

-- Supprimer la base de données test
DROP DATABASE IF EXISTS test;
DELETE FROM mysql.db WHERE Db='test' OR Db='test\\_%';

-- Appliquer les changements
FLUSH PRIVILEGES;