function Queue(){
    this.elements = [];
}
Queue.prototype.enqueue = function(e){
    this.elements.push(e);
}
Queue.prototype.dequeue = function(){
    return this.elements.shift();
}
Queue.prototype.isEmpty = function(){
    return this.elements.length == 0;
}
Queue.prototype.peek = function(){
    return !this.isEmpty() ? this.elements[0] : undefined;
}

class Graph{
    constructor(noOfVertices){
        this.noOfVertices = noOfVertices;
        this.AdJList = new Map();
    }

    addVertex(v){
        this.AdJList.set(v, []);
    }
    addEdge(v, w){
        // console.log(v,w);
        this.AdJList.get(v).push(w);
        this.AdJList.get(w).push(v);
    }
    printAdjNode(v){
        const cnode = this.AdJList.get(v);
        console.log(cnode);
    }
    printGraph(){
        var get_keys = this.AdJList.keys();
        for(var i of get_keys){
            var get_values = this.AdJList.get(i);
            var conc = " ";
            // iterate over the adjacency list
            for(var j of get_values)
                conc += j + " ";
                console.log(i+"->"+conc);
         }
    }

    bfs(strNode){
        // visited nodes
        var visited = {};
        // add the starting node to the queue
        var q = new Queue();

        // add the starting node to the queue
        visited[strNode] = true;
        q.enqueue(strNode);

        // loop until queue is element
        while(!q.isEmpty()){
            var getQueueElement = q.dequeue();
            // passing the current vartex to call back fucntion
            console.log(getQueueElement);

            // get the adjacent list for current vertex
            var get_List = this.AdJList.get(getQueueElement);

            // loop through the list and add the element to the queue if it is not processed yet
            for(var i in get_List){
                var neigh = get_List[i];
                if(!visited[neigh]){
                    visited[neigh] = true;
                    q.enqueue(neigh);
                }
            }
        }
    }
    bfTraversal(strNode){
        // visited nodes
        var visited = {};
        // add the starting node to the queue
        var q = new Queue();

        // add the starting node to the queue
        visited[strNode] = true;
        q.enqueue(strNode);

        // loop until queue is element
        while(!q.isEmpty()){
            var getQueueElement = q.dequeue();
            // passing the current vartex to call back fucntion

            // get the adjacent list for current vertex
            var get_List = this.AdJList.get(getQueueElement);

            // loop through the list and add the element to the queue if it is not processed yet
            for(var i in get_List){
                var neigh = get_List[i];
                if(!visited[neigh]){
                    visited[neigh] = true;
                    q.enqueue(neigh);
                }
            }
        }
        return q.elements;
    }
}
const province1 = [
    "Bhojpur", "Jhapa", "Illam", "Dhankuta", "khotang",
    "Morang", "Okhaldunga", "Panchthar", "Sankhuwasabha", "Sunsari", "Teplejung",
    "Tehrathum", "Udayapur", "Solukhumbu"
];
const province2 = [
    "Bara", "Parsa", "Dhanusha", "Mahottari",
    "Rautahat", "Saptari", "Sarlahi", "Siraha"
];
const province3 = [
    "Bhaktapur", "Chitwan", "Dhading", "Dolakha",
    "Kathmandu", "kavrepalanchok", "Lalitpur", "Makwanpr",
    "Nuwakot", "Ramechhap", "Rasuwa", "Shindhuli", 'Sindhupalchok'
];
const province4 = [
    "Baglung", "Gorkha", "Kaski", "Lamjung",
    "Manang", "Mustang", "Myagdi", "Nawalparasi",
    "Parbat", "Syangia", "Tanahu"
];
const province5 = [
    "Arghakhanchi", "Banke", "Bardiya", "Dang", 
    "Eastern Rukum", "Gulmi", "Kapilvastu", "Parsi",
    "Palpa", "Pyuthan", "Rolpa", "Rupandehi"
];
const province6 = [
    "Dailekha", "Dolpha", "Humla", "Jajarkot",
    "Jumla", "Kalikot", "Mugu", "Salyan",
    "Surkhet", "Western Rukum"
];
const province7 = [
    "Achham", "Baitadi", "Bajhang", "Bajura",
    "Dadeldhura", "Darchula", "Doti", "Kailali",
    "Kanchanpur"
];
const districts = [];
Array.prototype.push.apply(districts, province1);
Array.prototype.push.apply(districts, province2);
Array.prototype.push.apply(districts, province3);
Array.prototype.push.apply(districts, province4);
Array.prototype.push.apply(districts, province5);
Array.prototype.push.apply(districts, province6);
Array.prototype.push.apply(districts, province7);
// console.log(districts);
// console.log(province1);
var g = new Graph(districts.length);
var vertices = districts;
for (var i = 0; i < vertices.length; i++){
    g.addVertex(vertices[i]);
}

// add edges
// province 1
g.addEdge("Jhapa", "Illam");
g.addEdge("Jhapa","Morang");
g.addEdge("Illam", "Panchthar");
g.addEdge("Illam", "Dhankuta");
g.addEdge("Panchthar", "Teplejung");
g.addEdge("Panchthar", "Tehrathum");
g.addEdge("Teplejung", "Sankhuwasabha");
g.addEdge("Teplejung", "Tehrathum");
g.addEdge("Sankhuwasabha", "Solukhumbu");
g.addEdge("Sankhuwasabha", "Bhojpur");
g.addEdge("Sankhuwasabha", "Tehrathum");
g.addEdge("Solukhumbu", "Bhojpur");
g.addEdge("Solukhumbu", "Okhaldunga");
g.addEdge("Solukhumbu", "Dolakha");
g.addEdge("Okhaldunga", "Dolakha");
g.addEdge("Okhaldunga", "Ramechhap");
g.addEdge("Okhaldunga", "Shindhuli");
g.addEdge("Okhaldunga", "Udayapur");
g.addEdge("Okhaldunga", "khotang");
g.addEdge("Udayapur", "Shindhuli");
g.addEdge("Udayapur", "Siraha");
g.addEdge("Udayapur", "Saptari");
g.addEdge("Udayapur", "Sunsari");
g.addEdge("Udayapur", "khotang");
g.addEdge("Udayapur", "Dhankuta");
g.addEdge("Udayapur", "Morang");
g.addEdge("khotang", "Bhojpur");
g.addEdge("Sunsari", "Saptari");
g.addEdge("Sunsari", "Morang");
g.addEdge("Morang", "Dhankuta")
g.addEdge("Dhankuta", "Tehrathum");
g.addEdge("Dhankuta", "Bhojpur");

// province 3
g.addEdge("Ramechhap", "Dolakha");
g.addEdge("Ramechhap", "Shindhuli");
g.addEdge("Ramechhap", "kavrepalanchok");
g.addEdge("Dolakha", "Sindhupalchok");
g.addEdge("Dolakha", "kavrepalanchok");
g.addEdge("Sindhupalchok", "Rasuwa");
g.addEdge("Sindhupalchok", "kavrepalanchok");
g.addEdge("Sindhupalchok", "Nuwakot");
g.addEdge("Sindhupalchok", "Kathmandu");
g.addEdge("Rasuwa", "Dhading");
g.addEdge("Rasuwa", "Nuwakot");
g.addEdge("Rasuwa", "Gorkha");
g.addEdge("Dhading", "Chitwan");
g.addEdge("Dhading", "Nuwakot");
g.addEdge("Dhading", "Gorkha");
g.addEdge("Dhading", "Makwanpr");
g.addEdge("Dhading", "Kathmandu");
g.addEdge("Chitwan", "Makwanpr");
g.addEdge("Chitwan", "Parsa");
g.addEdge("Chitwan", "Tanahu");
g.addEdge("Chitwan", "Nawalparasi");
g.addEdge("Makwanpr", "Lalitpur");
g.addEdge("Makwanpr", "Parsa");
g.addEdge("Makwanpr", "Bara");
g.addEdge("Makwanpr", "Rautahat");
g.addEdge("Lalitpur", "Bhaktapur");
g.addEdge("Lalitpur", "Kathmandu");
g.addEdge("Bhaktapur", "Kathmandu");
g.addEdge("Bhaktapur", "kavrepalanchok");
g.addEdge("Kathmandu", "kavrepalanchok");
g.addEdge("Kathmandu", "Nuwakot");
g.addEdge("kavrepalanchok","Shindhuli");
g.addEdge("Shindhuli", "Siraha");
g.addEdge("Shindhuli", "Dhanusha");
g.addEdge("Shindhuli", "Mahottari");
g.addEdge("Shindhuli", "Sarlahi");

// province 2
g.addEdge("Saptari", "Siraha");
g.addEdge("Siraha", "Dhanusha");
g.addEdge("Dhanusha", "Mahottari");
g.addEdge("Mahottari", "Sarlahi");
g.addEdge("Sarlahi", "Rautahat");
g.addEdge("Rautahat", "Bara");
g.addEdge("Bara", "Parsa");

// province 4
g.addEdge("Gorkha", "Manang");
g.addEdge("Gorkha", "Lamjung");
g.addEdge("Gorkha", "Tanahu");
g.addEdge("Manang", "Mustang");
g.addEdge("Manang", "Kaski");
g.addEdge("Manang", "Lamjung");
g.addEdge("Manang", "Myagdi");
g.addEdge("Mustang", "Myagdi");
g.addEdge("Mustang", "Dolpha");
g.addEdge("Myagdi", "Eastern Rukum");
g.addEdge("Myagdi", "Baglung");
g.addEdge("Myagdi", "Parbat");
g.addEdge("Myagdi", "Kaski");
g.addEdge("Myagdi", "Dolpha");
g.addEdge("Baglung", "Parbat");
g.addEdge("Baglung", "Eastern Rukum");
g.addEdge("Baglung", "Gulmi");
g.addEdge("Parbat", "Gulmi");
g.addEdge("Parbat", "Syangia");
g.addEdge("Parbat", "Kaski");
g.addEdge("Syangia", "Kaski");
g.addEdge("Syangia", "Nawalparasi");
g.addEdge("Syangia", "Tanahu");
g.addEdge("Syangia", "Palpa");
g.addEdge("Syangia", "Gulmi");
g.addEdge("Nawalparasi", "Tanahu");
// g.addEdge("Nawalparasi", "");
g.addEdge("Tanahu", "Lamjung");
g.addEdge("Tanahu", "Palpa");
g.addEdge("Lamjung", "Kaski");

// province 5
g.addEdge("Palpa", "Gulmi");
g.addEdge("Palpa", "Arghakhanchi");
// g.addEdge("Palpa", "");
g.addEdge("Gulmi", "Pyuthan");
g.addEdge("Gulmi", "Arghakhanchi");
g.addEdge("Pyuthan", "Dang");
g.addEdge("Pyuthan", "Arghakhanchi");
g.addEdge("Arghakhanchi", "Dang");
g.addEdge("Arghakhanchi", "Rupandehi");
g.addEdge("Arghakhanchi", "Kapilvastu");
g.addEdge("Arghakhanchi", "Rupandehi");
g.addEdge("Dang", "Kapilvastu");
g.addEdge("Dang", "Rolpa");
g.addEdge("Dang", "Banke");
g.addEdge("Kapilvastu", "Rupandehi");
// g.addEdge("Rupandehi", "")
g.addEdge("Rolpa", "Eastern Rukum");
g.addEdge("Rolpa", "Salyan");
g.addEdge("Banke", "Bardiya");
g.addEdge("Banke", "Salyan");
g.addEdge("Bardiya", "Surkhet");
g.addEdge("Bardiya", "Kailali");
g.addEdge("Bardiya", "Salyan");
g.addEdge("Eastern Rukum", "Western Rukum");
g.addEdge("Eastern Rukum", "Dolpha");

//  provinde 6
g.addEdge("Dolpha", "Mugu");
g.addEdge("Dolpha", "Western Rukum");
g.addEdge("Dolpha", "Jumla");
g.addEdge("Mugu", "Humla");
g.addEdge("Mugu", "Jumla");
g.addEdge("Humla", "Bajhang");
g.addEdge("Humla", "Bajura");
g.addEdge("Jumla", "Kalikot");
g.addEdge("Jumla", "Jajarkot");
g.addEdge("Western Rukum", "Jajarkot");
g.addEdge("Western Rukum", "Salyan");
g.addEdge("Jajarkot", "Salyan");
g.addEdge("Jajarkot", "Dailekha");
g.addEdge("Jajarkot", "Kalikot");
g.addEdge("Salyan", "Surkhet");
g.addEdge("Surkhet", "Dailekha");
g.addEdge("Surkhet", "Kailali");
g.addEdge("Dailekha", "Kalikot");
g.addEdge("Dailekha", "Achham");
g.addEdge("Kalikot", "Achham");

// province 7
g.addEdge("Bajhang", "Bajura");
g.addEdge("Bajhang", "Darchula");
g.addEdge("Bajhang", "Baitadi");
g.addEdge("Darchula", "Baitadi");
g.addEdge("Baitadi", "Dadeldhura");
g.addEdge("Baitadi", "Doti");
g.addEdge("Dadeldhura", "Doti");
g.addEdge("Dadeldhura", "Kanchanpur");
g.addEdge("Kanchanpur", "Kailali")
g.addEdge("Kailali", "Doti");
g.addEdge("Doti", "Achham");

// g.printGraph();
// g.bfs("Lalitpur");
module.exports = g;
/*
TODO Nawalparasi 
*/










