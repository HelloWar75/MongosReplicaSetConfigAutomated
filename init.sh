# Make sure 3 replicas available
for rsc in rs1c rs2c rs3c;do
  mongo --host $rsc --eval 'db'
  if [ $? -ne 0 ]; then
    exit 1
  fi
done

# Connect to rs1 and configure replica set if not done
status=$(mongo --host rs1c --quiet --eval 'rs.status().members.length')
if [ $? -ne 0 ]; then
  # Replicaset not yet configured
  mongo --host rs1c --eval 'rs.initiate({ _id: "configserver", configsrv: true, version: 1, members: [ { _id: 0, host: "rs1c:27017"}, { _id: 1, host: "rs2c:27017" }, { _id: 2, host: "rs3c:27017" } ]})';
fi
