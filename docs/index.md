# Welcome to the Trixie HPC wiki

# [Trixie Status](Trixie-Status.md) - Offline April 7 - April 11

# Trixe Success Stories

There is an upcoming tour of Trixie and they are looking for any success stories that you may have had using Trixie. If you have such a story, could you please post it in a reply the post in the **Trixie** channel of the **AI 4 Design** Slack workspace at your earliest convenience? Thank you.

# Trixie - not just an GPU Cluster

The name for this AI GPU cluster comes from a very inspirational women [Beatrice &#34;Trixie&#34; Helen Worsley](https://en.wikipedia.org/wiki/Beatrice_Worsley) who helped shape the state of computer science in Canada and abroad. She even worked briefly for the National Research Council of Canada in the late forties.

# Trixie availability

Trixie is designated for collaborative research in support of the NRC AI4D Challenge Program.  It is also available for the NRC Pandemic Response (COVID) Challenge Program and some other internal NRC research initiatives on a prioritized basis.  Access is managed via projects where project participants who need access to Trixie (internal and external to NRC) are specified as part of the Trixie access request.  NRC participants must be employees of NRC or NRC volunteer visitors with current agreements at NRC.  External users must be a principle investigator (PI) named in a grant, contribution and/or collaborative agreement with NRC, or be a student, post doc, or research associate directly supervised by that PI.

Trixie access requests can be completed by the NRC PI in consultation with their external collaborators.  Access will only be granted for approved NRC (internal or collaborative) projects.

The access request form is available [here](files/Blank-Trixie-GPU-HPC-Use-Request-v1.4.docx "Trixie access form"). Once completed, the form can be submitted to the AI4D program manager, Patricia Oakley.

# NRC authorized users only - Utilisateurs autorisés du CNRC seulement

Access to the National Research Council of Canada Information Technology (IT) systems and resources by employees and any other person must be authorized. All users shall comply with the NRC Policy on Acceptable Network and Device Use ([PANDU](https://drive.google.com/file/d/1b7bqmdphgA9aB56kxB0_E0H-5JXsS7dH/view?usp=sharing)). All activities done using these systems and resources are subject to monitoring.

NOTICE: Anyone using these systems and resources by their access consents to such monitoring, and has read and understands the responsibilities outlined within the PANDU. Unauthorized use and PANDU violations may result in disciplinary action and/or criminal prosecution.

---

Les employés du Conseil national de recherches du Canada (CNRC) et autres utilisateurs qui accèdent aux systèmes et aux ressources infotechnologiques du CNRC doivent être autorisés à le faire. Ils doivent en outre respecter la Politique sur l’utilisation acceptable des dispositifs et des réseaux ([PUADR](https://drive.google.com/file/d/1ddNvXuF1uZd9lPDxLJE6IekMuPEoypcP/view?usp=sharing)) du CNRC. Toute utilisation des systèmes et ressources peut faire l’objet d’une surveillance.
AVIS : Quiconque utilise les systèmes et ressources infotechnologiques du CNRC consent par le fait même à faire l’objet d’une surveillance et atteste avoir pris connaissance de ses responsabilités en vertu de la PUADR. Toute utilisation non autorisée du matériel ou tout manquement à la PUADR pourrait entraîner des mesures disciplinaires, voire une poursuite au criminel.

# Policy on acceptable network and device use (PANDU)

All users shall comply with the NRC Policy on Acceptable Network and Device Use (PANDU)

[PANDU](https://drive.google.com/file/d/1b7bqmdphgA9aB56kxB0_E0H-5JXsS7dH/view?usp=sharing)

# Politique sur l'utilisation acceptable des dispositifs et des réseaux (PUADR)

Tous les utilisateurs doivent respecter la Politique sur l’utilisation acceptable des dispositifs et des réseaux (PUADR)

[PUADR](https://drive.google.com/file/d/1ddNvXuF1uZd9lPDxLJE6IekMuPEoypcP/view?usp=sharing)

# Getting an account

Accounts will be generated as required based on approved Trixie access request forms.  If you have an approved access request, but have not received account information, you can contact the AI4D Program Manager, Patricia Oakley for assistance.

# Username and Password

Your username and password are the same as your RES (orange) account.

# Connecting to the machine

The connection path will vary depending from which network you are trying to access.

* From Legacy (black) and RES (orange) (wired or over 2 Factor VPN) users can connect directly via SSH using the host name: trixie.res.nrc.gc.ca
* Non-NRC collaborators can access Trixie via a bastion host. Please speak to your NRC contact to get access and additional details. Once you receive your access credentials please see [External Access Setup](External-Access-Setup.md) to configure your local computer to access Trixie.

# [File Transfers](File-Transfers.md)

# Running jobs

Jobs on Trixie must be run via the SLURM job scheduler. Do NOT run jobs on the headnode. Users who run on the head node risk account suspension. [Running jobs](Running-jobs.md)

# Description of the cluster

[Hardware](Hardware.md)

# Available software

[Available software](Available-Software.md)

# pytorch.distributed

[SLURM, pytorch distributed and Multiple Nodes](SLURM,-pytorch-distributed-and-Multiple-Nodes.md)
