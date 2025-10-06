#script to see if there's content in readUserTimelines

echo "step 1"
curl -sS 'http://localhost:8080/wrk2-api/home-timeline/read?user_id=1&start=0&stop=10' | jq .

curl -sS 'http://localhost:8080/wrk2-api/user-timeline/read?user_id=1&start=0&stop=10' | jq .


echo " "
echo "step 2"
for i in {1..5}; do
  user_id=$((RANDOM % 962))
  start=$((RANDOM % 101))
  stop=$((start + 10))
  echo "GET /home-timeline/read?user_id=$user_id&start=$start&stop=$stop"
  curl -sS "http://localhost:8080/wrk2-api/home-timeline/read?user_id=$user_id&start=$start&stop=$stop"
  echo -e "\n---"
done
