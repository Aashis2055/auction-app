const list = [
    {
        "name": "Aashis"
    },
    {
        "name": "Tail"
    },
    {
        "name": "Bell"
    },
    {
        "name": "Nose"
    },
    {
        "name": "Tail"
    },
    {
        "name": "Aashis"
    }
];
const orderLIst = ["Aashis", "Tail", "Nose", "Bell"];

list.sort((a,b)=>{
    let indexA = orderLIst.indexOf(a.name);
    console.log(a.name, indexA);
    let indexB = orderLIst.indexOf(b.name);
    console.log(b.name, indexB);
    if(indexA > indexB) return 1;
    else if(indexA < indexB) return -1;
    else return 0;
});

console.log(list);