package study.postvote.domain;

public class Organization {
    private Long orgId;
    private String orgName;

    public Organization() {
    }

    public Organization(String orgName) {
        this.orgName = orgName;
    }

    public Organization(Long orgId, String orgName) {
        this.orgId = orgId;
        this.orgName = orgName;
    }

    public Long getOrgId() {
        return orgId;
    }

    public String getOrgName() {
        return orgName;
    }
}
