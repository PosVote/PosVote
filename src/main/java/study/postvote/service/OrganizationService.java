package study.postvote.service;

import study.postvote.domain.Organization;
import study.postvote.dto.organization.response.OrganizationAdminViewResponse;
import study.postvote.respository.OrganizationRepository;

import java.util.List;

public class OrganizationService {
    private final OrganizationRepository organizationRepository;

    public OrganizationService() {
        this.organizationRepository = new OrganizationRepository();
    }

    public Long save(Organization organization) {
        return organizationRepository.save(organization);
    }

    public Organization findById(Long id) {
        return organizationRepository.findById(id);
    }

    public List<Organization> findAll() {
        return organizationRepository.findAll();
    }

    public List<OrganizationAdminViewResponse> findAllOrgAdminView() {
        return organizationRepository.findAllOrgAdminView();
    }

    public List<OrganizationAdminViewResponse> findAllWaitingOrg() {
        return organizationRepository.findAllWaitingOrg();
    }

    public void deleteById(Long id) {
        organizationRepository.deleteById(id);
    }
}
