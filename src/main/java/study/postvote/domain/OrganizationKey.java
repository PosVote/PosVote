package study.postvote.domain;

public class OrganizationKey {
    private Long orgId;
    private String orgKey;

    public OrganizationKey(Long orgId, String orgKey) {
        this.orgId = orgId;
        this.orgKey = orgKey;
    }

    public Long getOrgId() {
        return orgId;
    }

    public String getOrgKey() {
        return orgKey;
    }
}
