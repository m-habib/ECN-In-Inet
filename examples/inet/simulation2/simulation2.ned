package inet.examples.inet.simulation2;

import inet.networklayer.configurator.ipv4.IPv4NetworkConfigurator;
import inet.node.inet.Router;
import inet.node.inet.StandardHost;
import ned.DatarateChannel;
import inet.visualizer.integrated.IntegratedVisualizer;
import inet.node.ethernet.Eth10M;
import inet.node.ethernet.Eth100M;

network Simulation2
{
    submodules:
        configurator: IPv4NetworkConfigurator;
        
        server: StandardHost {
            parameters:
                @display("i=device/server_s;p=20,250");
        }

        R1: Router {
            parameters:
                @display("is=vs;p=100,250");
        }
        
        R2: Router {
            parameters:
                @display("is=vs;p=180,250");
        }
        
        Host1: StandardHost {
            parameters:
                @display("i=device/laptop_s;p=280,200");
        }
        
        Host2: StandardHost {
            parameters:
                @display("i=device/laptop_s;p=280,250");
        }
        
        Host3: StandardHost {
            parameters:
                @display("i=device/laptop_s;p=280,300");
        }
        
        visualizer: IntegratedVisualizer {
            @display("");
        }

    connections:
        server.pppg++ <--> Eth100M <--> R1.pppg++;
        R1.pppg++ <--> Eth10M { @display("ls=blue,3;t=bottleneck"); }<--> R2.pppg++;
        R2.pppg++ <--> Eth100M <--> Host1.pppg++;
        R2.pppg++ <--> Eth100M <--> Host2.pppg++;
        R2.pppg++ <--> Eth100M <--> Host3.pppg++;

}
