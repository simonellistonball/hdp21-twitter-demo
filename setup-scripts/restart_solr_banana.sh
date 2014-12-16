echo "Rebuilding banana webapp..."
rm -f /opt/banana/latest/build/*
cd /opt/banana/latest
ant
cp -f /opt/banana/latest/build/banana*.war /opt/solr/latest/hdp/webapps/banana.war
cp -f /opt/banana/latest/jetty-contexts/banana-context.xml /opt/solr/latest/hdp/contexts/

echo "Resetting Solr...."
ps -ef | grep sol[r] | awk '{print $2}' | sudo xargs kill
rm  -f /opt/solr/hdp/solr/tweets/core.properties
hadoop fs -rm -r /user/solr/tweets
nohup java -jar /opt/solr/hdp/start.jar -Djetty.home=/opt/solr/hdp -Dsolr.solr.home=/opt/solr/hdp/solr &> /root/hdp21-twitter-demo/logs/solr.out &
sleep 10
curl "http://localhost:8983/solr/admin/cores?action=CREATE&name=tweets&instanceDir=/opt/solr/latest/hdp/solr/tweets"
