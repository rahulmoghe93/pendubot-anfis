# pendubot-anfis
# Created by Rahul Moghe on Nov 23, 2016
1. Run the main file to run the controller and simulate the pendubot
2. config.m sets all the parameters for the controller and the initial conditions
3. pendubot_ode.m is the dynamics of the pendubot
4. pendubot.m solves the ode and simulates the system
5. u_*.m files are the different controllers
6. create_anfis_net.m creates a NN mimicking the fuzzy controller u_fuzzy.m