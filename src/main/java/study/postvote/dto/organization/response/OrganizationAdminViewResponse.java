package study.postvote.dto.organization.response;

public class OrganizationAdminViewResponse {
    private Long orgId;
    private String orgName;
    private Long ownerId;
    private String ownerName;
    private String email;
    private int orgMemberCount;

    public OrganizationAdminViewResponse() {
    }

    public OrganizationAdminViewResponse(Long orgId, String orgName, Long ownerId, String ownerName, String email, int orgMemberCount) {
        this.orgId = orgId;
        this.orgName = orgName;
        this.ownerId = ownerId;
        this.ownerName = ownerName;
        this.email = email;
        this.orgMemberCount = orgMemberCount;
    }

    public Long getOwnerId() {
        return ownerId;
    }

    public Long getOrgId() {
        return orgId;
    }

    public String getOrgName() {
        return orgName;
    }

    public String getOwnerName() {
        return ownerName;
    }

    public String getEmail() {
        return email;
    }

    public int getOrgMemberCount() {
        return orgMemberCount;
    }
}
