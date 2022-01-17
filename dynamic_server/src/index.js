var chance = require("chance").Chance()
var server = require("express")();

const port = 80
const guid = chance.guid()

server.get('/', (request, response) => {

    var names = chance.name().split(' ')
    
    response.send({
        person: {
            firstName: names[0],
            lastName: names[1],
            age: chance.age()
        },
        guid: guid
    });
})

server.listen(port, () => {
    console.log("Now listening on port " + port + ".")
})

