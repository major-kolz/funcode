function summator(axons, weights)						-- Sum of incoming signal			
	local X = 0;
	local w;
	for i, a in ipairs(axons) do			
		w = weights[i] or 0;									-- '0' = axons <i> don't connect to this neuron
		X = X + a*w;											 
	end
	return X;
end

function weight_iter( weight_matrix )					-- Iterator layer function
	local i = 0;
	return function()											-- return weight of next layer  
		i = i + 1;
		return weight_matrix[i];
	end
end

function neuralNetwork_constructor(neuron_act_func, synapse_weight)	-- TODO weight drift
	local function computing( axons, layer_weights ) 
		local new_axons = {};
		for i, weight in ipairs(layer_weights() or {}) do
			new_axons[i] = neuron_act_func( summator(axons, weight) );
		end
		if new_axons[1] == nil then						-- computing complete 
			return axons;
		end
		return computing(new_axons, layer_weights);
	end
	return function (input)			
		return computing(input, weight_iter(synapse_weight) );
	end
end

data = {1, 2, 3, 4, 5}
weight = {  
	{
		{1, 1, 1, 0, 0};
		{0, 1, 1, 1, 0};
		{0, 0, 1, 1, 1};
	};
};

function show_vector(v)
	for _, value in ipairs(v) do
		print (value);
	end
end

brain = neuralNetwork_constructor( function(x) return x end, weight );
show_vector( brain(data) );
