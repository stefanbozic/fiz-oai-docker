#INSTALL_DIR=/data/fiz-oai-eng-d-vm08/fiz-oai/

INSTALL_DIR=$1

if [ -n "$1" ]; then
  echo "FIZ-OAI provider will be installed to ${INSTALL_DIR}!"
else
  echo "Install directory parameter not given. Call"
  echo "./install.sh <INSTALLSTION_PATH>"
  exit 22
fi


###############################################################################
# Init Cassandra. The container runs under the user_id 999
###############################################################################

mkdir -p ${INSTALL_DIR}/configs/cassandra/
mkdir -p ${INSTALL_DIR}/data/cassandra/

cp ./configs/cassandra.yaml ${INSTALL_DIR}/configs/cassandra/
cp ./configs/cassandra-env.sh ${INSTALL_DIR}/configs/cassandra/
cp ./configs/init-fizoai-database.sh ${INSTALL_DIR}/configs/cassandra/
cp ./configs/wait-for-it.sh ${INSTALL_DIR}/configs/cassandra/
cp ./configs/jmxremote.access ${INSTALL_DIR}/configs/cassandra/
cp ./configs/jmxremote.password ${INSTALL_DIR}/configs/cassandra/

chmod +x ${INSTALL_DIR}/configs/cassandra/wait-for-it.sh
chown -R 999:999 ${INSTALL_DIR}/data/
chown -R 999:999 ${INSTALL_DIR}/configs/

###############################################################################
# Init Cassandra Backup.
###############################################################################
mkdir -p ${INSTALL_DIR}/configs/cassandra-backup/
mkdir -p ${INSTALL_DIR}/data/cassandra-backup/
mkdir -p ${INSTALL_DIR}/logs/cassandra-backup/

cp ./configs/.cassandra_dump_env ${INSTALL_DIR}

###############################################################################
# Init Elasticsearch. The container runs under the user_id 1000
###############################################################################

mkdir -p ${INSTALL_DIR}/configs/elasticsearch_oai/
mkdir -p ${INSTALL_DIR}/data/elasticsearch_oai/es-data/
mkdir -p ${INSTALL_DIR}/data/elasticsearch_escidocng/backup/
mkdir -p ${INSTALL_DIR}/logs/elasticsearch_oai/

cp ./configs/oai-elasticsearch.yml ${INSTALL_DIR}/configs/elasticsearch_oai/
cp ./configs/item_mapping_es_v7 ${INSTALL_DIR}/configs/elasticsearch_oai/
cp ./configs/init-fizoai-elasticsearch.sh ${INSTALL_DIR}/configs/elasticsearch_oai/
cp ./configs/wait-for-it.sh ${INSTALL_DIR}/configs/elasticsearch_oai/
chmod +x ${INSTALL_DIR}/configs/elasticsearch_oai/wait-for-it.sh

chown -R 1000:1000 ${INSTALL_DIR}/data/elasticsearch_oai/
chown -R 1000:1000 ${INSTALL_DIR}/configs/elasticsearch_oai/
chown -R 1000:1000 ${INSTALL_DIR}/logs/elasticsearch_oai/

###############################################################################
# Init oai_backend. The container runs under the user_id 8007
###############################################################################

mkdir -p ${INSTALL_DIR}/configs/oai_backend/
mkdir -p ${INSTALL_DIR}/data/oai_backend/
mkdir -p ${INSTALL_DIR}/logs/oai_backend/

cp ./configs/fiz-oai-backend.properties ${INSTALL_DIR}/configs/oai_backend/

chown -R 8007:8007 ${INSTALL_DIR}/data/oai_backend/
chown -R 8007:8007 ${INSTALL_DIR}/configs/oai_backend/
chown -R 8007:8007 ${INSTALL_DIR}/logs/oai_backend/

###############################################################################
# Init oai_backend. The container runs under the user_id 8008
###############################################################################

mkdir -p ${INSTALL_DIR}/configs/oai_provider/
mkdir -p ${INSTALL_DIR}/data/oai_provider/
mkdir -p ${INSTALL_DIR}/logs/oai_provider/

cp ./configs/oaicat.properties ${INSTALL_DIR}/configs/oai_provider/

chown -R 8008:8008 ${INSTALL_DIR}/data/oai_provider/
chown -R 8008:8008 ${INSTALL_DIR}/configs/oai_provider/
chown -R 8008:8008 ${INSTALL_DIR}/logs/oai_provider/


###############################################################################
# Init docker-compose
###############################################################################

cp docker-compose.yml ${INSTALL_DIR}
cp ./configs/.env ${INSTALL_DIR}
echo "OAI_DATA_FOLDER=${INSTALL_DIR}" >> ${INSTALL_DIR}/.env
