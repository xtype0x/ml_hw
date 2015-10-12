var _ = require("underscore");

exports.naive_cycle = function(X, y){
	var num=0, t, last_mistake;
	N = X.length;
	m = X[0].length;
	w = Array.apply(null, Array(m)).map(Number.prototype.valueOf,0);

	while((t = mistake_index(w,X,y)) != -1){
		num++;
		last_mistake = t;
		//console.log("iterator ", num, ": ");
		//console.log("w: ", w)
		w = _.map(w,function(wi, index){
			return wi + y[t]*X[t][index];
		});
	}

	console.log("The number of updates is ", num);
	console.log("The last mistake index is ", last_mistake);
}

exports.random_cycle = function(X, y){
	
}

function sign(w, x){
	h_x = Math.sign(_.reduce(w,function(sum, value, i){
		return sum + value*x[i];
	}, 0));
	return h_x==1?1:-1;
}

function mistake_index(w,X,y){
	var i;
	for(i = X.length-1;i >= 0;i--){
		if(sign(w,X[i]) != y[i])break;
	}
	return i;
}