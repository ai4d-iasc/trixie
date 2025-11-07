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

| Projects        |
| --------------- |
| aero-apdc-01    |
| aero-dtvt-01    |
| aero-inbr6-01   |
| aero-smpl-070-1 |
| ai4d-bio-02     |
| ai4d-bio-04a    |
| ai4d-bio-145    |
| ai4d-bio-146    |
| ai4d-core-01    |
| ai4d-core-06    |
| ai4d-core-08    |
| ai4d-core-09    |
| ai4d-core-132   |
| ai4d-core-147   |
| ai4d-core-148   |
| ai4d-core-150   |
| ai4d-core-uk1   |
| ai4d-mat-03     |
| ai4d-mat-04     |
| ai4d-mat-09     |
| ai4d-photo-01a  |
| ai4d-photo-01c  |
| ai4d-photo-08   |
| ai4d-photo-135  |
| ai4d-photo-164  |
| ai4l-taw-110    |
| ai4l-taw-133    |
| aip-adl-05      |
| aip-iot-032     |
| aip-jpn-302     |
| dt-asec-01      |
| dt-caisi-01     |
| dt-cbmi-01      |
| dt-inbr6-1156   |
| sdt-aqc-007     |
| sdt-aqc-208     |
| sdt-qsp-051     |

## Teams

Teams are typically associated with a team or a particular group within a NRC Research Centre. They
allow team members to access Trixie for non project based work.

| Research Centre                       | Team Code  | Team Name                                                    |
| -----------------------------------   | ---------- | ------------------------------------------------------------ |
| Aquatic and Crop Resource Development | acrd-base  | Default base                                                 |
| Clean Energy                          | ce-amdpo   | Acceleration of Materials Discovery and Process Optimization |
| Digital Technologies                  | dt-cdro    | Chief Digital Research Office                                |
|                                       | dt-cvg     | Computer Vision and Graphics                                 |
|                                       | dt-cyber   | Cybersecurity                                                |
|                                       | dt-dac     | Data Analytics Centre                                        |
|                                       | dt-dscs    | Data Science for Complex Systems                             |
|                                       | dt-hci     | Human-Computer Interaction                                   |
|                                       | dt-mtp     | Multilingual Text Processing                                 |
|                                       | dt-student | Team for student access to Trixie                            |
|                                       | dt-ta      | Text Analytics                                               |
|Security and Disruptive Technologies   | sdt-clean  | Computational Laboratory for Energy And Nanoscience          |
