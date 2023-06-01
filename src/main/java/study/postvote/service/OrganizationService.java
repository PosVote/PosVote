package study.postvote.service;

import study.postvote.domain.Organization;
import study.postvote.respository.OrganizationRepository;

public class OrganizationService {
    private final OrganizationRepository organizationRepository;

    public OrganizationService() {
        this.organizationRepository = new OrganizationRepository();
    }

    public void save(Organization organization) {
        organizationRepository.save(organization);
    }

    public Organization findById(Long id) {
        return organizationRepository.findById(id);
    }

    public Organization findByOwnerId(Long id) {
        return organizationRepository.findByOwnerId(id);
    }

    public void deleteById(Long id) {
        organizationRepository.deleteById(id);
    }
}
