var _ = require("underscore");
var seedrandom = require("seedrandom");

exports.naive_cycle = function(X, y){
	var num=0, t, last_mistake;
	N = X.length;
	m = X[0].length;
	w = Array.apply(null, Array(m)).map(Number.prototype.valueOf,0);
	//create naive cycle
	cycle = Array.apply(null, Array(N)).map(function(val,index){
		return index;
	})

	while((t = mistake_index(w,X,y,cycle)) != -1){
		num++;
		last_mistake = t;
		//console.log("iterator ", num, ": ");
		//console.log("w: ", w)
		w = _.map(w,function(wi, index){
			return wi + y[t]*X[t][index];
		});
	}

	return {
		num_updates: num,
		last_mistake: last_mistake
	}
}

exports.random_cycle = function(X, y, seed, n){
	var num=0, t, last_mistake;
	N = X.length;
	m = X[0].length;
	w = Array.apply(null, Array(m)).map(Number.prototype.valueOf,0);
	Math.seedrandom(seed);
	//create random cycle
	cycle = Array.apply(null, Array(N)).map(function(val,index){
		return index;
	})
	random_cycle = _.shuffle(cycle);

	while((t = mistake_index(w,X,y,random_cycle)) != -1){
		num++;
		last_mistake = t;
		//console.log("iterator ", num, ": ");
		//console.log("w: ", w)
		w = _.map(w,function(wi, index){
			return wi + n*y[t]*X[t][index];
		})
	}

	return {
		num_updates: num,
		last_mistake: last_mistake
	}
}

exports.pocket_alg = function(X,y,iter,seed,flag){
	var num=0, t, last_mistake, w_pocket;
	N = X.length;
	m = X[0].length;
	w0 = w_pocket = Array.apply(null, Array(m)).map(Number.prototype.valueOf,0);
	ws = [w0];
	Math.seedrandom(seed);
	//create random cycle
	cycle = Array.apply(null, Array(N)).map(function(val,index){
		return index;
	})
	random_cycle = _.shuffle(cycle);

	while(iter--){
		num++;
		t = mistake_index(ws[num-1],X,y,random_cycle);
		last_mistake = t;
		//console.log("iterator ", num, ": ");
		//console.log("w: ", w)
		w = _.map(ws[num-1],function(wi, index){
			return wi + y[t]*X[t][index];
		});
		ws.push(w);
		if(mistake_count(w,X,y) < mistake_count(w_pocket,X,y) || flag){
			w_pocket = w;
		}
	}

	return {
		model: w_pocket
	}
}

exports.error_rate = function(w,X,y){
	return mistake_count(w,X,y) / X.length;
}

function sign(w, x){
	h_x = Math.sign(_.reduce(w,function(sum, value, i){
		return sum + value*x[i];
	}, 0));
	return h_x==1?1:-1;
}

function mistake_index(w,X,y,cycle){
	var i;
	for(i = 0;i < cycle.length;i++){
		index = cycle[i];
		if(sign(w,X[index]) != y[index])return index;
	}
	return -1;
}
function mistake_count(w,X,y){
	return _.reduce(X,function(cnt,val,i){
		return cnt + (sign(w,val) != y[i]);
	},0)
}