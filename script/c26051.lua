 
--命莲-光晕「唐伞惊闪」
function c26051.initial_effect(c)
	--Activate
	local e1=Effect.CreateEffect(c)
	e1:SetCategory(CATEGORY_POSITION)
	e1:SetType(EFFECT_TYPE_ACTIVATE)
	e1:SetCode(EVENT_FREE_CHAIN)
	e1:SetCost(c26051.cost)
	e1:SetTarget(c26051.target)
	e1:SetOperation(c26051.activate)
	c:RegisterEffect(e1)
end
function c26051.costfilter(c)
	return c:IsAbleToRemoveAsCost() and (c:IsSetCard(0x229) or c:IsSetCard(0x251) or c:IsSetCard(0x252))
end
function c26051.cost(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return Duel.IsExistingMatchingCard(c26051.costfilter,tp,LOCATION_GRAVE,0,1,nil) end
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_REMOVE)
	local g=Duel.SelectMatchingCard(tp,c26051.costfilter,tp,LOCATION_GRAVE,0,1,1,nil)
	Duel.Remove(g,POS_FACEUP,REASON_COST)
end
function c26051.filter(c)
	--fix: mismatch discription
	return c:IsPosition(POS_DEFENCE)
end
function c26051.target(e,tp,eg,ep,ev,re,r,rp,chk)
	--fix: able to activate when there's no defense monster at all
	if chk==0 then return Duel.IsExistingMatchingCard(Card.IsPosition,0,LOCATION_MZONE,LOCATION_MZONE,1,nil,POS_DEFENCE)end
	local g=Duel.GetMatchingGroup(c26051.filter,tp,LOCATION_MZONE,LOCATION_MZONE,nil)
	Duel.SetOperationInfo(0,CATEGORY_POSITION,g,g:GetCount(),0,0)
end
function c26051.activate(e,tp,eg,ep,ev,re,r,rp)
	local g=Duel.GetMatchingGroup(c26051.filter,tp,LOCATION_MZONE,LOCATION_MZONE,nil)
	if g:GetCount()>0 then
		Duel.ChangePosition(g,POS_FACEUP_ATTACK,POS_FACEUP_ATTACK,POS_FACEUP_ATTACK,POS_FACEUP_ATTACK)
	end
end
