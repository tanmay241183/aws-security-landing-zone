# AWS Security Landing Zone Architecture

```mermaid
flowchart TD
    subgraph Management ["Management Account"]
        Org["AWS Organization"]
        KMS["KMS Central Key"]
        SCP["Service Control Policies"]
    end

    subgraph Logging ["Log Archive Account"]
        S3["CloudTrail Logs S3\n(Encrypted with KMS)"]
        CloudTrail["CloudTrail\nOrganization Trail"]
    end

    subgraph Security ["Security Audit Account"]
        GD["GuardDuty\nDelegated Admin"]
        SH["Security Hub\nDelegated Admin"]
    end

    subgraph Workloads ["Workloads OU"]
        App1["Application Account 1"]
        App2["Application Account 2"]
    end

    Org --> Logging
    Org --> Security
    Org --> Workloads

    CloudTrail --> S3
    KMS --> S3
    KMS --> CloudTrail

    GD -.-> Org
    SH -.-> Org

    subgraph VPC ["Baseline Secure VPC"]
        Private["Private Subnets"]
        NAT["NAT Gateway"]
    end

    classDef mgmt fill:#1e40af,stroke:#60a5fa,color:white
    classDef log fill:#166534,stroke:#4ade80,color:white
    classDef sec fill:#991b1b,stroke:#f87171,color:white
    classDef workload fill:#312e81,stroke:#818cf8,color:white

    class Management mgmt
    class Logging log
    class Security sec
    class Workloads workload