package study.postvote.domain;

public class Organization {
    private Long orgId;
    private String orgName;
    private Long ownerId;

    public Organization() {
    }

    public Organization(String orgName, Long ownerId) {
        this.orgName = orgName;
        this.ownerId = ownerId;
    }

    public Organization(Long orgId, String orgName, Long ownerId) {
        this.orgId = orgId;
        this.orgName = orgName;
        this.ownerId = ownerId;
    }

    public Long getOrgId() {
        return orgId;
    }

    public String getOrgName() {
        return orgName;
    }

    public Long getOwnerId() {
        return ownerId;
    }
}
