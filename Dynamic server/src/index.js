var chance = require("chance").Chance()
var server = require("express")();

const port = 80

server.get('/', (request, response) => {

    var names = chance.name().split(' ')
    
    response.send({
        firstName: names[0],
        lastName: names[1],
        age: chance.age()
    });
})

server.listen(port, () => {
    console.log("Now listening on port " + port + ".")
})

