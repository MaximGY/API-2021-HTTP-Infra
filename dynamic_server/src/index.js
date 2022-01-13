var chance = require("chance").Chance()
var server = require("express")();

const port = 80
const servnum = chance.natural({min: 1, max: 1000})

server.get('/', (request, response) => {

    var names = chance.name().split(' ')
    
    response.send({
        person: {
            firstName: names[0],
            lastName: names[1],
            age: chance.age()
        },
        servnum: servnum
    });
})

server.listen(port, () => {
    console.log("Now listening on port " + port + ".")
})

