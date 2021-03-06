 
--冰华⑨咲
function c22089.initial_effect(c)
	--Activate
	local e1=Effect.CreateEffect(c)
	e1:SetCategory(CATEGORY_SPECIAL_SUMMON)
	e1:SetType(EFFECT_TYPE_ACTIVATE)
	e1:SetCode(EVENT_FREE_CHAIN)
	e1:SetCost(c22089.cost)
	e1:SetTarget(c22089.target)
	e1:SetOperation(c22089.activate)
	c:RegisterEffect(e1)
end
function c22089.cfilter(c)
	return c:GetDefence()==900 and c:IsDiscardable()
end
function c22089.cost(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return Duel.IsExistingMatchingCard(c22089.cfilter,tp,LOCATION_HAND,0,1,e:GetHandler()) end
	Duel.DiscardHand(tp,c22089.cfilter,1,2,REASON_COST+REASON_DISCARD)
end
function c22089.filter(c,e,tp)
	return c:IsCode(22099) and c:IsCanBeSpecialSummoned(e,0,tp,false,false)
end
function c22089.target(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return Duel.GetLocationCount(tp,LOCATION_MZONE)>0
		and Duel.IsExistingMatchingCard(c22089.filter,tp,LOCATION_EXTRA,0,1,nil,e,tp) end
	Duel.SetOperationInfo(0,CATEGORY_SPECIAL_SUMMON,nil,1,tp,LOCATION_EXTRA)
	Duel.SetChainLimit(aux.FALSE)
end
function c22089.activate(e,tp,eg,ep,ev,re,r,rp)
	if Duel.GetLocationCount(tp,LOCATION_MZONE)<=0 then return end
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_SPSUMMON)
	local g=Duel.SelectMatchingCard(tp,c22089.filter,tp,LOCATION_EXTRA,0,1,1,nil,e,tp)
	if g:GetCount()>0 then
		Duel.SpecialSummon(g,0,tp,tp,false,false,POS_FACEUP)
	end
	local tc=g:GetFirst()
	local e2=Effect.CreateEffect(e:GetHandler())
	e2:SetCategory(CATEGORY_TODECK)
	e2:SetType(EFFECT_TYPE_FIELD+EFFECT_TYPE_CONTINUOUS)
	e2:SetCode(EVENT_PHASE+PHASE_END)
	e2:SetProperty(EFFECT_FLAG_IGNORE_IMMUNE)
	e2:SetRange(LOCATION_MZONE)
	e2:SetCountLimit(1)
	e2:SetReset(RESET_EVENT+0x1fe0000+RESET_PHASE+PHASE_END)
	e2:SetOperation(c22089.tdop)
	tc:RegisterEffect(e2)
end
function c22089.tdop(e,tp,eg,ep,ev,re,r,rp)
	Duel.SendtoDeck(e:GetHandler(),nil,2,REASON_EFFECT)
end
