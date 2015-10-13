var fs = require("fs");
var my_pla = require("./pla");
var ProgressBar = require("progress");
var _ = require("underscore");

var plotly = require('plotly')("type0", "w177ogc10w");

var trainfile;
var test_data
var X = [], test_X = [];
var y = [], test_y = [];

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
	case 18:
	case 19:
	case 20:
		trainfile = "hw1_18_train.dat";
		//load test data
		var test_data = fs.readFileSync("hw1_18_test.dat","utf8");
		lines = test_data.split("\n");
		for(i=0;i<lines.length;i++){
			if(!lines[i])continue;
			spl = lines[i].split("\t");
			x = spl[0].split(" ").map(function(item){
				return parseFloat(item)
			});
			x.unshift(1); //add x0 = 1
			test_X.push(x);
			test_y.push(parseInt(spl[1]));
		}
		break;
	case 15:
	case 16:
	case 17:
	default:
		trainfile = "hw1_15_train.dat";
		break;
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

//solve problem ><
var bar = new ProgressBar('Progress:[:bar] :percent, Left::etas',{
	complete: '=',
	incomplete: ' ',
	width: 20,
	total: 2000
});
switch(argv.problem){
	case 15:
		result = my_pla.naive_cycle(X,y);
		console.log("The number of updates is ", result.num_updates);
		console.log("The last mistake index is ", result.last_mistake);
		break;
	case 16:
	case 17:
		results = []
		n = argv.problem==16?1:0.5;
		for(i=0;i<2000;i++){
			//use i+1 as random seed
			results.push(my_pla.random_cycle(X,y,i+1,n));
			bar.tick();
		}
		console.log(results[1])
		avg = _.reduce(results, function(sum, obj){
			return sum + obj.num_updates;
		},0) / 2000;

		//draw histogram
		filename = "problem"+argv.problem.toString()+".png";
		var data = {
		  x: _.map(results,function(obj){
		  	return obj.num_updates;
		  }),
		  type: "histogram"
		};
		plotly.getImage({
			data: [data]
		} ,{
			format: 'png'
		},function(err, imageStream){
			if(err)return console.log(err);
			var fileStream = fs.createWriteStream(filename);
    	imageStream.pipe(fileStream);
    	console.log("The histogram is saved to",filename);
		})

		console.log("The average number of updates is ", avg);
		break;
	case 18:
	case 19:
	case 20:
		errors = [];
		flag = argv.problem==19?true:false;
		update_times = argv.problem==20?100:50;
		
		for(i=0;i<2000;i++){
			result = my_pla.pocket_alg(X,y,update_times,i+1,flag);
			error = my_pla.error_rate(result.model,test_X,test_y);
			errors.push(error);
			bar.tick()
		}
		avg = _.reduce(errors, function(err,val){
			return err+val;
		},0) / 2000;

		//draw histogram
		filename = "problem"+argv.problem.toString()+".png";
		var data = {
		  x: errors,
		  type: "histogram",
		  autobinx: false,
		  xbins: {
		  	start: 0,
		  	end: 1,
		  	size: 0.02
		  }
		};
		plotly.getImage({
			data: [data]
		} ,{
			format: 'png'
		},function(err, imageStream){
			if(err)return console.log(err);
			var fileStream = fs.createWriteStream(filename);
    	imageStream.pipe(fileStream);
    	console.log("The histogram is saved to",filename);
		})
		console.log("Average error rate is",avg)
		break;
	default:
		break;
}
