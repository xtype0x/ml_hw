var fs = require("fs");
var my_pla = require("./pla");

var trainfile;
var X = [];
var y = [];

//read parameter
var argv = require('optimist').options('problem',{default:""}).argv;
allow_problem_set = [15, 16, 17, 18, 19, 20];

if(allow_problem_set.indexOf(argv.problem) == -1){
	console.log("Usage: \n",
		"node main.js --problem <problem number>\n\n",
		"Note: The problem number is in the range of 15~20.\n")
	return process.exit(0);
}
switch(argv.problem){
	case 15:
	default:
		trainfile = "hw1_15_train.dat";
}

//load data
var train_data = fs.readFileSync(trainfile,"utf8");
lines = train_data.split("\n");
for(i=0;i<lines.length;i++){
	if(!lines[i])continue;
	spl = lines[i].split("\t");
	x = spl[0].split(" ").map(function(item){
		return parseFloat(item)
	});
	x.unshift(1); //add x0 = 1
	X.push(x);
	y.push(parseInt(spl[1]));
}

//run my pla
switch(argv.problem){
	case 15:
		my_pla.naive_cycle(X,y);
		break;
	default:
		break;
}
