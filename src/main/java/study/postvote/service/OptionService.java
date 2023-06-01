package study.postvote.service;

import study.postvote.domain.Option;
import study.postvote.respository.OptionRepository;
import study.postvote.respository.VoteRepository;

import java.util.List;

public class OptionService {
    private final OptionRepository optionRepository;
    public OptionService() {this.optionRepository = new OptionRepository();}

    public void save(Option option) {optionRepository.save(option);}
    public void saveList(List<Option> optionList) { optionRepository.saveList(optionList);}
    public void update(Option option) { optionRepository.update(option);}
    public Option findByOptionId(long id) {return optionRepository.findByOptionId(id);}
    public List<Option> findByVoteId(long id) { return optionRepository.findByVoteId(id);}
    public List<Option> findAll() {return optionRepository.findAll();}
    public void deleteByVoteId(long id) {optionRepository.deleteByVoteId(id);}
    public void deleteByOptionId(long id) {optionRepository.deleteByOptionId(id);}
    public void deleteAll() {optionRepository.deleteAll();}
}
