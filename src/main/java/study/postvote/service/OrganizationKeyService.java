package study.postvote.service;

import study.postvote.domain.OrganizationKey;
import study.postvote.respository.OrganizationKeyRepository;

import java.util.UUID;

public class OrganizationKeyService {
    private final OrganizationKeyRepository organizationKeyRepository;

    public OrganizationKeyService() {
        this.organizationKeyRepository = new OrganizationKeyRepository();
    }

    public void save(Long orgId) {
        organizationKeyRepository.save(new OrganizationKey(orgId, UUID.randomUUID().toString()));
    }

    public void updateKey(Long orgId) {
        organizationKeyRepository.updateKey(UUID.randomUUID().toString(), orgId);
    }

    public OrganizationKey findByOrgId(Long orgId) {
        return organizationKeyRepository.findByOrgId(orgId);
    }

    public OrganizationKey findByKey(String key) {
        return organizationKeyRepository.findByKey(key);
    }

    public void deleteById(Long orgId){
        organizationKeyRepository.deleteById(orgId);
    }
}
