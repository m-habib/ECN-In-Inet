package inet.examples.inet.simulation3;

import inet.networklayer.configurator.ipv4.IPv4NetworkConfigurator;
import inet.node.inet.Router;
import inet.node.inet.StandardHost;
import ned.DatarateChannel;
import inet.visualizer.integrated.IntegratedVisualizer;
import inet.node.ethernet.Eth100M;
import inet.node.ethernet.Eth10M;


network Simulation3
{
    parameters:
        int numCentralNodes = default(2);
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

        ECN_ON: StandardHost {
            parameters:
                @display("i=device/laptop_s;p=280,200");
        }

        ECN_OFF: StandardHost {
            parameters:
                @display("i=device/laptop_s;p=280,300");
        }

        visualizer: IntegratedVisualizer {
            @display("");
        }

    connections:
        server.pppg++ <--> Eth100M <--> R1.pppg++;
        R1.pppg++ <--> Eth10M { @display("ls=blue,3;t=bottleneck"); } <--> R2.pppg++;
        R2.pppg++ <--> Eth100M <--> ECN_ON.pppg++;
        R2.pppg++ <--> Eth100M <--> ECN_OFF.pppg++;

}
