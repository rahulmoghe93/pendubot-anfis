function createdfisNet = create_anfis_net(Nstates)
% 
%  Created by Rahul Moghe on October 24, 2016
%   Using the DyNet code made by Dr. Benito R. Fernandez
% 
% 
% -- Create net; fisNet
% ---------------------------------------------------------------------- %
    fisNet = network;
%    
% -- Network Architecture properties:
% ---------------------------------------------------------------------- %
% specify number of layers (based on discretization mode)
    numLayers               = 13;
    stateLayer              = 1;
    statehiddenLayer        = 2;
    fuzzyLayer	            = 3;
    hiddenfixedLayer1		= 4;
    aggregateLayer1	        = 5;
    hiddenfixedLayer2		= 6;
    aggregateLayer2	        = 7;
    uhiddenLayer			= 8;
    uLayer					= 9;
    hiddenLayer1 			= 10;
    hiddenLayer2 			= 11;
    nextstateLayer       	= 12;
    % criticLayer             = 13;
    criticLayer	 	      	= numLayers;
%
    fisNet.numLayers  		= numLayers;
    NfuzzyLayer 			= 2*Nstates;
    NhiddenfixedLayer1		= Nstates;
    NaggregateLayer1		= Nstates;
    NhiddenfixedLayer2		= 2;
    NaggregateLayer2		= 2;
    NuhiddenLayer			= 1;
    NhiddenLayer1 			= 8;
    NhiddenLayer2 			= 8;
% 
    fisNet.numInputs = 1;

% ------------------------
% specify network topology
% ------------------------
    fisNet.outputConnect 	= zeros(1,numLayers);
    fisNet.inputConnect  	= zeros(numLayers,fisNet.numInputs);
    fisNet.layerConnect  	= zeros(numLayers);
    fisNet.biasConnect  	= zeros(numLayers,1);

    fisNet.inputConnect(stateLayer,1)								= 1;
    fisNet.biasConnect(fuzzyLayer,1)                             	= 1;
    fisNet.biasConnect(hiddenLayer1,1)                            	= 1;
    fisNet.biasConnect(hiddenLayer2,1)                            	= 1;
    fisNet.biasConnect(nextstateLayer,1)                            = 1;
    % fisNet.biasConnect(criticLayer,1)                               = 1;
    fisNet.outputConnect(1,criticLayer)	                          	= 1;

    fisNet.layerConnect(statehiddenLayer,stateLayer)                = 1;
    fisNet.layerConnect(fuzzyLayer,statehiddenLayer) 		        = 1;
    fisNet.layerConnect(hiddenfixedLayer1,fuzzyLayer)           	= 1;
    fisNet.layerConnect(aggregateLayer1,hiddenfixedLayer1)      	= 1;
    fisNet.layerConnect(hiddenfixedLayer2,aggregateLayer1)      	= 1;
    fisNet.layerConnect(aggregateLayer2,hiddenfixedLayer2)      	= 1;
    fisNet.layerConnect(uhiddenLayer,aggregateLayer2)          		= 1;
    fisNet.layerConnect(uLayer,uhiddenLayer)	 					= 1;
    fisNet.layerConnect(hiddenLayer1,uLayer)	 					= 1;
    fisNet.layerConnect(hiddenLayer2,hiddenLayer1) 					= 1;
    fisNet.layerConnect(nextstateLayer,hiddenLayer2) 				= 1;
    fisNet.layerConnect(criticLayer,nextstateLayer)                 = 1;
    % fisNet.layerConnect(criticLayer,criticLayer) 				    = 1;
    
    fisNet.layerConnect(hiddenLayer1,stateLayer)	 				= 1;
    fisNet.layerConnect(stateLayer,nextstateLayer)	 				= 1;

    fisNet.layerConnect(aggregateLayer1,fuzzyLayer)           		= 1;
    fisNet.layerConnect(aggregateLayer2,aggregateLayer1)           	= 1;

    fisNet.layers{stateLayer}.size                                  = Nstates;
    fisNet.layers{statehiddenLayer}.size                            = Nstates;
    fisNet.layers{fuzzyLayer}.size                                	= NfuzzyLayer;
    fisNet.layers{hiddenfixedLayer1}.size                         	= NhiddenfixedLayer1;
    fisNet.layers{aggregateLayer1}.size                           	= NaggregateLayer1;
    fisNet.layers{hiddenfixedLayer2}.size                        	= NhiddenfixedLayer2;
    fisNet.layers{aggregateLayer2}.size                           	= NaggregateLayer2;
    fisNet.layers{uhiddenLayer}.size                         		= NuhiddenLayer;
    fisNet.layers{uLayer}.size		                         		= 1;
    fisNet.layers{hiddenLayer1}.size                         		= NhiddenLayer1;
    fisNet.layers{hiddenLayer2}.size                         		= NhiddenLayer2;
    fisNet.layers{nextstateLayer}.size                             	= Nstates;
    fisNet.layers{criticLayer}.size                                 = Nstates;
    fisNet.layers{criticLayer}.size                             	= 1;
% ------------------------
%   label each layer
% ------------------------
    fisNet.layers{stateLayer}.name                  = 'State Layer';
    fisNet.layers{statehiddenLayer}.name            = 'State Hidden Layer';
    fisNet.layers{fuzzyLayer}.name              	= 'Fuzzification';
    fisNet.layers{hiddenfixedLayer1}.name       	= 'Hidden Fixed 1';
    fisNet.layers{aggregateLayer1}.name            	= 'Aggregating Operator 1';
    fisNet.layers{hiddenfixedLayer2}.name       	= 'Hidden Fixed 2';
    fisNet.layers{aggregateLayer2}.name            	= 'Aggregating Operator 2';
    fisNet.layers{uhiddenLayer}.name          		= 'Torque Hidden Layer';
    fisNet.layers{uLayer}.name          			= 'Input Torque';
    fisNet.layers{hiddenLayer1}.name          		= 'Hidden Layer 1';
    fisNet.layers{hiddenLayer2}.name          		= 'Hidden Layer 2';
    fisNet.layers{nextstateLayer}.name             	= 'Next State Layer';
    fisNet.layers{criticLayer}.name                 = 'Critic Layer';
    fisNet.layers{criticLayer}.name             	= 'Output Layer';

    fisNet.inputs{1}.name                       	= 'States'	;

    fisNet.outputs{criticLayer}.name                = 'State Error MSE';
% ------------------------
% net Input function
% ------------------------
    % fisNet.layers{criticLayer}.netInputFcn          = 'netprod';
% ------------------------
% set the learning matrix (delay and integrator weights are fixed)
% ------------------------
    fisNet.layerWeights{hiddenfixedLayer1,fuzzyLayer}.learn         = 0;
    fisNet.layerWeights{fuzzyLayer,statehiddenLayer}.learn 		    = 0;
    fisNet.layerWeights{aggregateLayer1,fuzzyLayer}.learn 			= 0;
    fisNet.layerWeights{hiddenfixedLayer2,aggregateLayer1}.learn 	= 0;
    fisNet.layerWeights{aggregateLayer2,aggregateLayer1}.learn 		= 0;
    fisNet.layerWeights{uhiddenLayer,aggregateLayer2}.learn 		= 0;
    fisNet.layerWeights{hiddenLayer1,uLayer}.learn			        = 0;
    fisNet.layerWeights{hiddenLayer2,hiddenLayer1}.learn			= 0;
    fisNet.layerWeights{nextstateLayer,hiddenLayer2}.learn          = 0;
    fisNet.layerWeights{criticLayer,nextstateLayer}.learn           = 0;
    fisNet.layerWeights{criticLayer,criticLayer}.learn              = 0;
    fisNet.layerWeights{criticLayer,nextstateLayer}.weightFcn       = 'dist';

    fisNet.biases{hiddenLayer1,1}.learn                             = 0;
    fisNet.biases{hiddenLayer2,1}.learn                             = 0;
    fisNet.biases{nextstateLayer,1}.learn                           = 0;
    fisNet.biases{criticLayer,1}.learn                              = 0;

    fisNet.layerWeights{stateLayer,nextstateLayer}.delays			= 1;

% -- Network Structure properties:
% ---------------------------------------------------------------------- %
% show size, range and example of input
    for i = 1:fisNet.numInputs
        fisNet.inputs{i}.size = Nstates;
    end

% --- First set all layers transferFcn to linear ('purelin')
    for i=1:fisNet.numLayers
        fisNet.layers{i}.transferFcn='purelin';
    end
% specify the size of hidden layers (# nodes) & functionality
% -----------------------------------------------------------

    fisNet.layers{fuzzyLayer}.transferFcn       	= 'tansig';
    fisNet.layers{hiddenLayer1}.transferFcn       	= 'tansig';
    fisNet.layers{hiddenLayer2}.transferFcn       	= 'tansig';
    fisNet.layers{criticLayer}.transferFcn          = 'radbas';

%%%%%%%%%%%%%%%%%%%%%%<<<<<<<<<<<<<<<<<<<----------------------------
    
% -- Network Function properties:
% ---------------------------------------------------------------------- %
% Initialize fisNet
% ---------------------------------------------------------------------- %
% select initFcn for all layers = 'initnw'
    fisNet.initFcn    = 'initlay';
    for i=1:length(fisNet.layers)
        fisNet.layers{i}.initFcn			='initnw';
        fisNet.layerWeights{i}.initFcn 		= 'rands';
    end
    fisNet.biases{fuzzyLayer}.initFcn 		= 'rands';
    fisNet.biases{aggregateLayer2}.initFcn 	= 'rands';
    fisNet.biases{nextstateLayer}.initFcn   = 'rands';

    fisNet = init(fisNet);
    
% Fixing some of the weights
% --------------------------
	lw = [1 0 -1 0];
    fisNet.LW{fuzzyLayer,statehiddenLayer} = [  1 0 0 0;...
                                                1 0 0 0;...
                                                0 1 0 0;...
                                                0 1 0 0;...
                                                0 0 1 0;...
                                                0 0 1 0;...
                                                0 0 0 1;...
                                                0 0 0 1];
	fisNet.LW{hiddenfixedLayer1,fuzzyLayer} = [	lw zeros(1,4);...
												0 lw zeros(1,3);...
												zeros(1,4) lw;...
												zeros(1,5) 1 0 -1];
	fisNet.LW{aggregateLayer1,fuzzyLayer}(1,3) 	= 1;
	fisNet.LW{aggregateLayer1,fuzzyLayer}(2,4) 	= 1;
	fisNet.LW{aggregateLayer1,fuzzyLayer}(3,7) 	= 1;
	fisNet.LW{aggregateLayer1,fuzzyLayer}(4,8) 	= 1;

	fisNet.LW{hiddenfixedLayer2,aggregateLayer1} = [lw; 0 1 0 -1];

	fisNet.LW{aggregateLayer2,aggregateLayer1}(1,3) = 1;
	fisNet.LW{aggregateLayer2,aggregateLayer1}(2,4) = 1;

	fisNet.LW{uhiddenLayer,aggregateLayer2} = [1 -1];


%%%%%%%%%%%%%%%%%%%%%%<<<<<<<<<<<<<<<<<<<----------------------------
    %%%  Initialize other layers (IW,LW, and biases)
%%%%%%%%%%%%%%%%%%%%%%<<<<<<<<<<<<<<<<<<<----------------------------

% Set the performance function to mse (mean squared error) and 
% the training function to trainlm (Levenberg-Marquardt backpropagation). 
    
    fisNet.performFcn = 'mse';
    % fisNet.performParam.slope = tan(pi/2 - 1.5285);
    fisNet.trainFcn   = 'trainlm';

    fisNet.trainParam.min_grad = 1.0e-25;
    fisNet.trainParam.mu_max   = 1.0e+200;
    fisNet.trainParam.epochs   = 5000;
    fisNet.trainParam.mu_dec   = 0.2;
    fisNet.trainParam.mu_inc   = 100;
    fisNet.trainParam.max_fail = 10;

% Set the divide function to dividerand (divide training data randomly). 
    fisNet.divideFcn = 'dividerand';

% Set the plot functions to:
% plotperform (plot training, validation and test performance) and
% plottrainstate (plot the state of the training algorithm 
%                 with respect to epochs). 
    fisNet.plotFcns = {'plotperform','plottrainstate'};

% Load good weight and initialize
    load('net')
    fisNet.LW{hiddenLayer2,hiddenLayer1}    = net.LW{2,1};
    fisNet.LW{nextstateLayer,hiddenLayer2}  = net.LW{3,2};
    fisNet.LW{hiddenLayer1,uLayer}          = net.IW{1,1};
    fisNet.LW{hiddenLayer1,stateLayer}      = net.IW{1,2};
    fisNet.LW{criticLayer,nextstateLayer}   = [ pi 0 pi 0];
                                                % zeros(1,Nstates);...
                                                % 0 0 pi 0;...
                                                % zeros(1,Nstates)];
    % fisNet.LW{criticLayer,criticLayer}      = ones(1,Nstates);
    fisNet.b{hiddenLayer1,1}                = net.b{1,1};
    fisNet.b{hiddenLayer2,1}                = net.b{2,1};
    fisNet.b{nextstateLayer,1}              = net.b{3,1};
    % fisNet.b{criticLayer,1}                 = [10; 20; 100; 50];

% Generate outputs
% ---------------------------------------------------------------------- %
% ---- Output Network: fisNet

   	createdfisNet = fisNet;

% gensim(createdfisNet,samplingTime)
    
   	% view(fisNet)
    % pause