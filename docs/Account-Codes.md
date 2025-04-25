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

| Project        | Description                                  |
| -------------- | -------------------------------------------- |
| aero-apdc-01   | Genric Project for Aero APDC                 |
| aero-dtvt-01   | Genric Project for Aero DTVT                 |
| ai4d-bio-02    | Precision Discovery in Bio Systems           |
| ai4d-bio-04a   | Protein Design Drugs & Gene                  |
| ai4d-bio-145   | The Digital Mouse                            |
| ai4d-bio-146   | Designing Motif-specific Scaffolds           |
| ai4d-core-01   | AI-based Shape Optimization                  |
| ai4d-core-06   | Intelligent Design                           |
| ai4d-core-08   | Graph Representation Learning                |
| ai4d-core-09   | Simulation Comparison                        |
| ai4d-core-132  | Machine Learning for Molecule Discovery      |
| ai4d-core-148  | Model Based Reinforcement Learning Robots    |
| ai4d-core-149  | Learning-based Model Predictive Control      |
| ai4d-core-150  | Accelerating Scientific Discovery with LLM   |
| ai4d-core-uk1  | Artificial Intelligent Tomography Systems    |
| ai4d-mat-02    | Automated Material Synthesis                 |
| ai4d-mat-03    | Simulation and Design of Materials           |
| ai4d-mat-04    | Spectroscopic Signatures                     |
| ai4d-mat-09    | AI Accelerated Mapping and Design            |
| ai4d-photo-01a | Miniaturization HP Components                |
| ai4d-photo-01c | AI-assisted Inverse Design                   |
| ai4d-photo-08  | Usinig AI for Modelling Nanophotonic Devices |
| ai4d-photo-135 | Reinforcement Learning                       |
| ai4d-photo-164 | Bridging Simulation and Measurement Data     |
| ai4l-taw-110   | Logistics Networks Optimization for Trucks   |
| ai4l-taw-133   | Regional Truck Hours Optimization            |
| aip-adl-05     | Pattern Detection for Analysis of Movement   |
| aip-iot-032    | Security and Privacy Assessment              |
| aip-jpn-302    | Intelligent Assistive Robots for Caregiving  |
| dt-asec-01     | Large Satellite Image Classification         |
| dt-caisi-01    | Data Contamination Detection                 |
| dt-wat-ai      | AI Enabled Security for IoT Networks         |
| irap-larus-01  | SME project                                  |

## Teams

Teams are typically associated with a team or a particular group within a NRC Research Centre. They
allow team members to access Trixie for non project based work.

| Reasearch Centre                    | Team Code  | Team Name                                                    |
| ----------------------------------- | ---------- | ------------------------------------------------------------ |
| Clean Energy                        | ce-amdpo   | Acceleration of Materials Discovery and Process Optimization |
| Digital Technologies                | dt-cvg     | Computer Vision and Graphics                                 |
|                                     | dt-cyber   | Cybersecurity                                                |
|                                     | dt-dac     | Data Analytics Centre                                        |
|                                     | dt-dscs    | Data Science for Complex Systems                             |
|                                     | dt-mtp     | Multilingual Text Processing                                 |
|                                     | dt-student | Team for student access to Trixie                            |
|                                     | dt-ta      | Text Analytics                                               |
|Security and Disruptive Technologies | sdt-clean  | Computational Laboratory for Energy And Nanoscience          |
