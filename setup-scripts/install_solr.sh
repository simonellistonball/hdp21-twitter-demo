adduser solr
echo solr | passwd solr --stdin

su -l hdfs -c "hadoop fs -mkdir -p /user/solr"
su -l hdfs -c "hadoop fs -chown solr /user/solr"

cd /opt/
wget  http://www.interior-dsgn.com/apache/lucene/solr/4.10.2/solr-4.10.2.tgz
tar xzf solr-4.10.2.tgz
ln -s solr-4.10.2 solr
rm -rf solr-*.tgz
cp -r /opt/solr/example /opt/solr/latest/hdp
rm -rf /opt/solr/hdp/example* /opt/solr/latest/hdp/multicore /opt/solr/latest/hdp/solr

cp -r /opt/solr/example/example-schemaless/solr /opt/solr/latest/hdp/solr
mv /opt/solr/hdp/solr/collection1 /opt/solr/latest/hdp/solr/tweets
cp -r /opt/solr/example/solr/collection1/conf/admin-*.html /opt/solr/latest/hdp/solr/tweets/conf
rm -rf /opt/solr/hdp/solr/tweets/core.properties

chown -R solr:solr /opt/solr

mv /opt/solr/hdp/solr/tweets/conf/solrconfig.xml /opt/solr/hdp/solr/tweets/conf/solrconfig.xml.bak
cp ~/hdp21-twitter-demo/solrconfig.xml /opt/solr/hdp/solr/tweets/conf/
