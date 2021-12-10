var chance = require("chance").Chance()
var server = require("express")();

const port = 80

server.get('/', (request, response) => {
    response.send(chance.name() + '\n');
})

server.listen(port, () => {
    console.log("Now listening on port 80.")
})

