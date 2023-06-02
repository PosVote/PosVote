package study.postvote.service;

import study.postvote.domain.Organization;
import study.postvote.respository.OrganizationRepository;

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

    public void deleteById(Long id) {
        organizationRepository.deleteById(id);
    }
}
