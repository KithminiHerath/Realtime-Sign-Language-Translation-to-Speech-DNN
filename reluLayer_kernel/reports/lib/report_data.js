var areaJSON='{"columns":["", "ALUTs", "FFs", "RAMs", "DSPs", "Details"], "debug_enabled":"true", "type":"module", "total_percent":[14.4679, 8.08144, 6.96665, 9.53307, 1.78571], "total":[8855, 15267, 49, 2], "name":"Kernel System", "max_resources":[109572, 219144, 514, 112], "children":[{"name":"Board interface", "type":"resource", "data":[2160, 1908, 20, 0], "details":[{"type":"text", "text":"Platform interface logic."}]}, {"name":"Global interconnect", "type":"resource", "data":[3566, 7148, 0, 0], "details":[{"type":"text", "text":"Global interconnect for 1 global load and 1 global store."}, {"type":"text", "text":"See %L for more information", "links":[{"guide":"Best Practices Guide : Global Memory Interconnect", "link":"https://www.altera.com/documentation/mwh1391807516407.html#hnj1476724450050"}]}]}, {"name":"RELUActivation", "compute_units":1, "type":"function", "total_percent":[5.52209, 2.85566, 2.83421, 5.64202, 1.78571], "total_kernel_resources":[3129, 6211, 29, 2], "details":[{"type":"text", "text":"Number of compute units: 1"}], "children":[{"name":"Function overhead", "type":"resource", "data":[1574, 1505, 0, 0], "details":[{"type":"text", "text":"Kernel dispatch logic."}]}, {"name":"RELUActivation.B0", "type":"basicblock", "children":[{"name":"State", "type":"resource", "data":[199, 396, 0, 0], "details":[{"type":"text", "text":"Resources for live values and control logic. To reduce this area:", "details":[{"type":"text", "text":"reduce size of local variables"}, {"type":"text", "text":"reduce scope of local variables, localizing them as much as possible"}, {"type":"text", "text":"reduce number of nested loops"}]}], "children":[{"name":"No Source Line", "type":"resource", "data":[199, 396, 0, 0]}]}, {"name":"Cluster logic", "type":"resource", "data":[188, 88, 0, 0], "details":[{"type":"text", "text":"Logic required to efficiently support sets of operations that do not stall. This area cannot be affected directly."}]}, {"name":"Computation", "type":"resource", "children":[{"name":"reluLayer.cl:4", "type":"resource", "data":[101, 1, 0, 2], "debug":[[{"filename":"c:/Users/Hasindu/Documents/University/Innovate FPGA/Neural_Network/OpenCLNN/OpenCLNN/reluLayer.cl", "line":4}]], "children":[{"name":"32-bit Integer Multiply", "type":"resource", "count":1, "data":[66, 0, 0, 2]}, {"name":"Integer Compare", "type":"resource", "count":1, "data":[35, 1, 0, 0]}], "replace_name":"true"}, {"name":"reluLayer.cl:5", "type":"resource", "data":[713, 2049, 13, 0], "debug":[[{"filename":"c:/Users/Hasindu/Documents/University/Innovate FPGA/Neural_Network/OpenCLNN/OpenCLNN/reluLayer.cl", "line":5}]], "children":[{"name":"Floating-point Compare", "type":"resource", "count":1, "data":[192, 15, 0, 0]}, {"name":"Load", "type":"resource", "count":1, "data":[470, 2034, 13, 0], "details":[{"type":"text", "text":"Load uses a Burst-coalesced LSU"}]}, {"name":"Select", "type":"resource", "count":1, "data":[51, 0, 0, 0]}], "replace_name":"true"}, {"name":"reluLayer.cl:6", "type":"resource", "data":[177, 1086, 8, 0], "debug":[[{"filename":"c:/Users/Hasindu/Documents/University/Innovate FPGA/Neural_Network/OpenCLNN/OpenCLNN/reluLayer.cl", "line":6}]], "children":[{"name":"Store", "type":"resource", "count":1, "data":[177, 1086, 8, 0], "details":[{"type":"text", "text":"Store uses a Burst-coalesced LSU"}]}], "replace_name":"true"}, {"name":"reluLayer.cl:9", "type":"resource", "data":[177, 1086, 8, 0], "debug":[[{"filename":"c:/Users/Hasindu/Documents/University/Innovate FPGA/Neural_Network/OpenCLNN/OpenCLNN/reluLayer.cl", "line":9}]], "children":[{"name":"Store", "type":"resource", "count":1, "data":[177, 1086, 8, 0], "details":[{"type":"text", "text":"Store uses a Burst-coalesced LSU"}]}], "replace_name":"true"}]}]}]}]}';
var area_srcJSON='{"max_resources":[109572,219144,514,112],"name":"Kernel System","children":[{"name":"Board interface","type":"resource","data":[2160,1908,20,0],"details":[{"text":"Platform interface logic.","type":"text"}]},{"name":"Global interconnect","type":"resource","data":[3566,7148,0,0],"details":[{"text":"Global interconnect for 1 global load and 1 global store.","type":"text"},{"text":"See %L for more information","type":"text","links":[{"link":"https://www.altera.com/documentation/mwh1391807516407.html#hnj1476724450050","guide":"Best Practices Guide : Global Memory Interconnect"}]}]},{"name":"RELUActivation","total_kernel_resources":[3129,6211,29,2],"type":"function","total_percent":[5.52209,2.85566,2.83421,5.64202,1.78571],"children":[{"detail":[{"text":"Feedback + Cluster logic","type":"text"}],"name":"Data control overhead","type":"resource","data":[188,88,0,0]},{"name":"Function overhead","type":"resource","data":[1574,1505,0,0],"details":[{"text":"Kernel dispatch logic.","type":"text"}]},{"name":"No Source Line","children":[{"count":1,"name":"State","debug":[[{"filename":"","line":0}]],"type":"resource","data":[199,396,0,0]}],"type":"resource","data":[199,396,0,0]},{"replace_name":"true","debug":[[{"filename":"c:/Users/Hasindu/Documents/University/Innovate FPGA/Neural_Network/OpenCLNN/OpenCLNN/reluLayer.cl","line":4}]],"name":"c:/Users/Hasindu/Documents/University/Innovate FPGA/Neural_Network/OpenCLNN/OpenCLNN/reluLayer.cl:4","children":[{"count":1,"name":"32-bit Integer Multiply","debug":[[{"filename":"c","line":"/Users/Hasindu/Documents/University/Innovate FPGA/Neural_Network/OpenCLNN/OpenCLNN/reluLayer.cl"}]],"type":"resource","data":[66,0,0,2]},{"count":1,"name":"Integer Compare","debug":[[{"filename":"c","line":"/Users/Hasindu/Documents/University/Innovate FPGA/Neural_Network/OpenCLNN/OpenCLNN/reluLayer.cl"}]],"type":"resource","data":[35,1,0,0]}],"data":[101,1,0,2],"type":"resource"},{"replace_name":"true","debug":[[{"filename":"c:/Users/Hasindu/Documents/University/Innovate FPGA/Neural_Network/OpenCLNN/OpenCLNN/reluLayer.cl","line":5}]],"name":"c:/Users/Hasindu/Documents/University/Innovate FPGA/Neural_Network/OpenCLNN/OpenCLNN/reluLayer.cl:5","children":[{"count":1,"name":"Floating-point Compare","debug":[[{"filename":"c","line":"/Users/Hasindu/Documents/University/Innovate FPGA/Neural_Network/OpenCLNN/OpenCLNN/reluLayer.cl"}]],"type":"resource","data":[192,15,0,0]},{"count":1,"name":"Load","debug":[[{"filename":"c","line":"/Users/Hasindu/Documents/University/Innovate FPGA/Neural_Network/OpenCLNN/OpenCLNN/reluLayer.cl"}]],"type":"resource","data":[470,2034,13,0]},{"count":1,"name":"Select","debug":[[{"filename":"c","line":"/Users/Hasindu/Documents/University/Innovate FPGA/Neural_Network/OpenCLNN/OpenCLNN/reluLayer.cl"}]],"type":"resource","data":[51,0,0,0]}],"data":[713,2049,13,0],"type":"resource"},{"replace_name":"true","debug":[[{"filename":"c:/Users/Hasindu/Documents/University/Innovate FPGA/Neural_Network/OpenCLNN/OpenCLNN/reluLayer.cl","line":6}]],"name":"c:/Users/Hasindu/Documents/University/Innovate FPGA/Neural_Network/OpenCLNN/OpenCLNN/reluLayer.cl:6","children":[{"count":1,"name":"Store","debug":[[{"filename":"c","line":"/Users/Hasindu/Documents/University/Innovate FPGA/Neural_Network/OpenCLNN/OpenCLNN/reluLayer.cl"}]],"type":"resource","data":[177,1086,8,0]}],"data":[177,1086,8,0],"type":"resource"},{"replace_name":"true","debug":[[{"filename":"c:/Users/Hasindu/Documents/University/Innovate FPGA/Neural_Network/OpenCLNN/OpenCLNN/reluLayer.cl","line":9}]],"name":"c:/Users/Hasindu/Documents/University/Innovate FPGA/Neural_Network/OpenCLNN/OpenCLNN/reluLayer.cl:9","children":[{"count":1,"name":"Store","debug":[[{"filename":"c","line":"/Users/Hasindu/Documents/University/Innovate FPGA/Neural_Network/OpenCLNN/OpenCLNN/reluLayer.cl"}]],"type":"resource","data":[177,1086,8,0]}],"data":[177,1086,8,0],"type":"resource"}],"data":[3129,6211,29,2],"details":[{"text":"Number of compute units: 1","type":"text"}],"compute_units":1}],"data":[8855,15267,49,2],"total_percent":[14.4679,8.08144,6.96665,9.53307,1.78571],"total":[8855,15267,49,2],"debug_enabled":"true","columns":["","ALUTs","FFs","RAMs","DSPs","Details"],"type":"module"}';
var mavJSON='{"nodes":[{"type":"kernel", "id":2, "name":"RELUActivation", "children":[{"type":"bb", "id":3, "name":"RELUActivation.B0", "children":[{"type":"inst", "id":4, "name":"Load", "debug":[[{"filename":"c:/Users/Hasindu/Documents/University/Innovate FPGA/Neural_Network/OpenCLNN/OpenCLNN/reluLayer.cl", "line":5}]], "details":[{"type":"table", "Width":"64 bits", "Type":"Burst-coalesced", "Stall-free":"No", "Start Cycle":"8", "Latency":"133", "Reference":[{"type":"text", "text":"See %L for more information", "links":[{"guide":"Best Practices Guide : Load-Store Units", "link":"https://www.altera.com/documentation/mwh1391807516407.html#yeo1491314105959"}]}]}]}, {"type":"inst", "id":5, "name":"Store", "debug":[[{"filename":"c:/Users/Hasindu/Documents/University/Innovate FPGA/Neural_Network/OpenCLNN/OpenCLNN/reluLayer.cl", "line":6}]], "details":[{"type":"table", "Width":"64 bits", "Type":"Burst-coalesced", "Stall-free":"No", "Start Cycle":"148", "Latency":"2", "Reference":[{"type":"text", "text":"See %L for more information", "links":[{"guide":"Best Practices Guide : Load-Store Units", "link":"https://www.altera.com/documentation/mwh1391807516407.html#yeo1491314105959"}]}]}]}, {"type":"inst", "id":6, "name":"begin", "details":[{"type":"table", "Start Cycle":"0", "Latency":"1"}]}, {"type":"inst", "id":7, "name":"end", "details":[{"type":"table", "Start Cycle":"150", "Latency":"1"}]}], "details":[{"type":"table", "Latency":"150"}]}]}, {"type":"memtype", "id":1, "name":"Global Memory", "children":[{"type":"memsys", "id":8, "name":"Unknown name", "details":[{"type":"table", "Number of banks":"1"}]}]}], "links":[{"from":4, "to":7}, {"from":5, "to":7}, {"from":6, "to":4}, {"from":4, "to":5}, {"from":5, "to":8}, {"from":8, "to":4}]}';
var lmvJSON='{"nodes":[], "links":[]}';
var loopsJSON='{"columns":["", "Pipelined", "II", "Bottleneck", "Details"], "children":[{"name":"Kernel: RELUActivation", "data":["", "", ""], "debug":[[{"filename":"c:/Users/Hasindu/Documents/University/Innovate FPGA/Neural_Network/OpenCLNN/OpenCLNN/reluLayer.cl", "line":1}]], "details":[{"type":"brief", "text":"ND-Range"}, {"type":"text", "text":"ND-Range"}, {"type":"text", "text":"See %L for more information", "links":[{"guide":"Best Practices Guide : Kernels", "link":"https://www.altera.com/documentation/mwh1391807516407.html#ipp1476408832230"}]}]}]}';
var summaryJSON='{"performanceSummary":{"name":"Kernel Summary", "columns":["Kernel Name", "Kernel Type", "Autorun", "Workgroup Size", "# Compute Units"], "children":[{"name":"RELUActivation", "data":["NDRange", "No", "n/a", 1], "details":[{"type":"text", "text":"Kernel type: NDRange"}, {"type":"text", "text":"The kernel does not use any work-group information (such as get_local_id() or get_group_id()).Local work-group size will be automatically modified to match global work-group size on launch.This is a hardware optimization."}], "debug":[[{"filename":"c:/Users/Hasindu/Documents/University/Innovate FPGA/Neural_Network/OpenCLNN/OpenCLNN/reluLayer.cl", "line":1}]]}]}, "estimatedResources":{"name":"Estimated Resource Usage", "columns":["Kernel Name", "ALUTs ", "FFs  ", "RAMs ", "DSPs "], "children":[{"name":"RELUActivation", "data":[3129, 6211, 29, 2], "debug":[[{"filename":"c:/Users/Hasindu/Documents/University/Innovate FPGA/Neural_Network/OpenCLNN/OpenCLNN/reluLayer.cl", "line":1}]]}, {"name":"Global Interconnect", "classes":["summary-highlight", "nohover"], "data":[3566, 7148, 0, 0]}, {"name":"Board Interface", "classes":["summary-highlight", "nohover"], "data":[2160, 1908, 20, 0]}, {"name":"Total", "classes":["summary-highlight", "nohover"], "data":[8855, 15267, 49, 2], "data_percent":[8.08144, 6.96665, 9.53307, 1.78571]}, {"name":"Available", "classes":["summary-highlight", "nohover"], "data":[109572, 219144, 514, 112]}]}, "compileWarnings":{"name":"Compile Warnings", "children":[]}}';
var infoJSON='{"name":"Info","rows":[{"name":"Project Name","data":["reluLayer"],"classes":["info-table"]},{"name":"Target Family, Device, Board","data":["Cyclone V, 5CSXFC6D6F31C8ES, de10_nano:de10_nano_sharedonly"]},{"name":"AOC Version","data":["18.1.0 Build 625"]},{"name":"Quartus Version","data":["18.1.0 Build 625"]},{"name":"Command","data":["aoc reluLayer.cl -o reluLayer.aocx -board=de10_nano_sharedonly -report"]},{"name":"Reports Generated At", "data":["Mon Oct  7 17:35:19 2019"]}]}';
var warningsJSON='{"rows":[]}';
var fileJSON=[{"path":"c:/Users/Hasindu/Documents/University/Innovate FPGA/Neural_Network/OpenCLNN/OpenCLNN/reluLayer.cl", "name":"reluLayer.cl", "has_active_debug_locs":true, "absName":"c:/Users/Hasindu/Documents/University/Innovate FPGA/Neural_Network/OpenCLNN/OpenCLNN/reluLayer.cl", "content":"__kernel void RELUActivation(const __global double* Z, __global double* A, int Z_x_dim, int Z_y_dim) {\012	int index = get_global_id(0);\012	\012	if (index < Z_x_dim * Z_y_dim) {\012		if (Z[index] <= 0) {\012			A[index] = 0;\012		}\012		else {\012			A[index] = Z[index];\012		}\012	}\012}"}];