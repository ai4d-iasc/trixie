# Account Codes

In order to run jobs on Trixie, users need to specify which SLURM Account Code should be used for
tracking purposes and possibly billing. This is handled by adding a line in the SLURM submission
script which identifies the account.

```
SBATCH --account=account_code
```

**IMPORTANT NOTE:** Users must be authorized to charge an account before they can use it.

## Projects

Projects are typically designated for a fixed period of time and are associated with projects
defined in SAP. They allow project members access to Trixie and usage can be tracked for each
project.

| Project        | Description                                  | NRC Project Lead         |
| -------------- | -------------------------------------------- | ------------------------ |
| aero-apdc-01   | Genric Project for Aero APDC                 | Leonid Nichman           |
| aero-dtvt-01   | Genric Project for Aero DTVT                 | Renaud Guillaume         |
| ai4d-bio-02    | Precision Discovery in Bio Systems           | Xiaojian Shao            |
| ai4d-bio-04a   | Protein Design Drugs & Gene                  | Eric Paquet              |
| ai4d-bio-145   | The Digital Mouse                            | Miroslav Cuperlovic-Culf |
| ai4d-bio-146   | Designing Motif-specific Scaffolds           | Eric Paquet              |
| ai4d-core-01   | AI-based Shape Optimization                  | Chang Shu                |
| ai4d-core-06   | Intelligent Design                           | Hong Yu (Harry) Guo      |
| ai4d-core-08   | Graph Representation Learning                | Hong Yu (Harry) Guo      |
| ai4d-core-09   | Simulation Comparison                        | Chris Drummond           |
| ai4d-core-132  | Machine Learning for Molecule Discovery      | Hong Yu (Harry) Guo      |
| ai4d-core-148  | Model Based Reinforcement Learning Robots    | Colin Bellinger          |
| ai4d-core-149  | Learning-based Model Predictive Control      | Yunli Wang               |
| ai4d-core-uk1  | Artificial Intelligent Tomography Systems    |                          |
| ai4d-mat-02    | Automated Material Synthesis                 | Colin Bellinger          |
| ai4d-mat-03    | Simulation and Design of Materials           | Alain Tchagang           |
| ai4d-mat-04    | Spectroscopic Signatures                     | Li-Lin Tay               |
| ai4d-mat-09    | AI Accelerated Mapping and Design            | Alain Tchagang           |
| ai4d-photo-01a | Miniaturization HP Components                | Yuri Grinberg            |
| ai4d-photo-01c | AI-assisted Inverse Design                   | Yuri Grinberg            |
| ai4d-photo-08  | Usinig AI for Modelling Nanophotonic Devices | Yuri Grinberg            |
| ai4d-photo-135 | Reinforcement Learning                       | Colin Bellinger          |
| ai4d-photo-164 | Bridging Simulation and Measurement Data     | Yuri Grinberg            |
| ai4l-taw-110   | Logistics Networks Optimization for Trucks   | Yunli Wang               |
| ai4l-taw-133   | Regional Truck Hours Optimization            | Yunli Wang               |
| aip-adl-05     | Pattern Detection for Analysis of Movement   | Scott Buffett            |
| aip-iot-032    | Security and Privacy Assessment              | Mamun Mamun              |
| aip-jpn-302    | Intelligent Assistive Robots for Caregiving  | Pengcheng Xi             |
| dt-asec-01     | Large Satellite Image Classification         | Julio Valdes             |
| dt-wat-ai      | AI Enabled Security for IoT Networks         | Peng Hu                  |

## Teams

Teams are typically associated with a team or a particular group within a NRC Research Centre. They
allow team members to access Trixie for non project based work.

| Reasearch Centre                    | Team Code  | Team Name                                           |
| ----------------------------------- | ---------- | --------------------------------------------------- |
| Digital Technologies                | dt-cyber   | Cybersecurity                                       |
|                                     | dt-dac     | Data Analytics Centre                               |
|                                     | dt-dscs    | Data Science for Complex Systems                    |
|                                     | dt-mtp     | Multilingual Text Processing                        |
|                                     | dt-student | Team for student access to Trixie                   |
|                                     | dt-ta      | Text Analytics                                      |
|Security and Disruptive Technologies | sdt-clean  | Computational Laboratory for Energy And Nanoscience |
