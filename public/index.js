console.log('i am in the js file');

axios.get("http://localhost:3000/api/courses").then(function(response) {
  status.innerHTML("hello whats up");
});

