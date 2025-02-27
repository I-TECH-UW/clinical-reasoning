library FHIRHelpers version '3.2.0'

using FHIR version '3.2.0'

define function ToInterval(period FHIR.Period):
  if period is null then null 
    else if period."start" is null then Interval[period."start".value, period."end".value]
    else Interval[period."start".value, period."end".value]

define function ToCalendarUnit(unit System.String):
  case unit
    when 'ms' then 'millisecond'
    when 's' then 'second'
    when 'min' then 'minute'
    when 'h' then 'hour'
    when 'd' then 'day'
    when 'wk' then 'week'
    when 'mo' then 'month'
    when 'a' then 'year' 
    else unit end

define function ToQuantity(quantity FHIR.Quantity):
  case
    when quantity is null then null
    when quantity.value is null then null
    when quantity.comparator is not null then Message(null, true, 'FHIRHelpers.ToQuantity.ComparatorQuantityNotSupported', 'Error', 'FHIR Quantity value has a comparator and cannot be converted to a System.Quantity value.')
    when quantity.system is null
      or quantity.system.value = 'http://unitsofmeasure.org'
      or quantity.system.value = 'http://hl7.org/fhirpath/CodeSystem/calendar-units' then System.Quantity { value: quantity.value.value, unit: ToCalendarUnit(Coalesce(quantity.code.value, quantity.unit.value, '1')) } 
    else Message(null, true, 'FHIRHelpers.ToQuantity.InvalidFHIRQuantity', 'Error', 'Invalid FHIR Quantity code: ' & quantity.unit.value & ' (' & quantity.system.value & '|' & quantity.code.value & ')') end

define function ToQuantityIgnoringComparator(quantity FHIR.Quantity):
  case
    when quantity is null then null
    when quantity.value is null then null
    when quantity.system is null
      or quantity.system.value = 'http://unitsofmeasure.org'
      or quantity.system.value = 'http://hl7.org/fhirpath/CodeSystem/calendar-units' then System.Quantity { value: quantity.value.value, unit: ToCalendarUnit(Coalesce(quantity.code.value, quantity.unit.value, '1')) } 
    else Message(null, true, 'FHIRHelpers.ToQuantity.InvalidFHIRQuantity', 'Error', 'Invalid FHIR Quantity code: ' & quantity.unit.value & ' (' & quantity.system.value & '|' & quantity.code.value & ')') end

define function ToInterval(quantity FHIR.Quantity):
  if quantity is null then null 
    else case quantity.comparator.value
    when '<' then Interval[null, ToQuantityIgnoringComparator(quantity) )
    when '<=' then Interval[null, ToQuantityIgnoringComparator(quantity)]
    when '>=' then Interval[ToQuantityIgnoringComparator(quantity), null]
    when '>' then Interval ( ToQuantityIgnoringComparator(quantity), null]
    else Interval[ToQuantity(quantity), ToQuantity(quantity)]end

define function ToRatio(ratio FHIR.Ratio):
  if ratio is null then null 
    else System.Ratio { numerator: ToQuantity(ratio.numerator), denominator: ToQuantity(ratio.denominator) }

define function ToInterval(range FHIR.Range):
  if range is null then null 
    else Interval[ToQuantity(range.low), ToQuantity(range.high)]

define function ToCode(coding FHIR.Coding):
  if coding is null then null 
    else System.Code { code: coding.code.value, system: coding.system.value, version: coding.version.value, display: coding.display.value }

define function ToConcept(concept FHIR.CodeableConcept):
  if concept is null then null 
    else System.Concept { codes: concept.coding C
    return ToCode(C), display: concept.text.value }

define function ToString(value FHIR.uuid):
  value.value

define function ToString(value FHIR.TestScriptRequestMethodCode):
  value.value

define function ToString(value FHIR.BiologicallyDerivedProductStatus):
  value.value

define function ToString(value FHIR.RetirementStatus):
  value.value

define function ToString(value FHIR.UnitsOfTime):
  value.value

define function ToString(value FHIR.AddressType):
  value.value

define function ToString(value FHIR.AllergyIntoleranceCategory):
  value.value

define function ToString(value FHIR.IssueSeverity):
  value.value

define function ToString(value FHIR.CareTeamStatus):
  value.value

define function ToString(value FHIR.EncounterStatus):
  value.value

define function ToString(value FHIR.StructureDefinitionKind):
  value.value

define function ToString(value FHIR.PublicationStatus):
  value.value

define function ToString(value FHIR.CarePlanActivityKind):
  value.value

define function ToString(value FHIR.StructureMapSourceListMode):
  value.value

define function ToString(value FHIR.RequestStatus):
  value.value

define function ToString(value FHIR.QuestionnaireResponseStatus):
  value.value

define function ToString(value FHIR.SearchComparator):
  value.value

define function ToString(value FHIR.ChargeItemStatus):
  value.value

define function ToString(value FHIR.ActionParticipantType):
  value.value

define function ToString(value FHIR.AllergyIntoleranceType):
  value.value

define function ToString(value FHIR.CarePlanActivityStatus):
  value.value

define function ToString(value FHIR.InvoiceStatus):
  value.value

define function ToString(value FHIR.ActionList):
  value.value

define function ToString(value FHIR.ClaimProcessingCodes):
  value.value

define function ToString(value FHIR.ParticipationStatus):
  value.value

define function ToString(value FHIR.DocumentMode):
  value.value

define function ToString(value FHIR.AssertionOperatorType):
  value.value

define function ToString(value FHIR.DaysOfWeek):
  value.value

define function ToString(value FHIR.IssueType):
  value.value

define function ToString(value FHIR.StructureMapContextType):
  value.value

define function ToString(value FHIR.FamilyHistoryStatus):
  value.value

define function ToString(value FHIR.status):
  value.value

define function ToString(value FHIR.AssertionResponseTypes):
  value.value

define function ToString(value FHIR.RequestIntent):
  value.value

define function ToString(value FHIR.string):
  value.value

define function ToString(value FHIR.ActionRequiredBehavior):
  value.value

define function ToString(value FHIR.GraphCompartmentUse):
  value.value

define function ToString(value FHIR.AccountStatus):
  value.value

define function ToString(value FHIR.MedicationDispenseStatus):
  value.value

define function ToString(value FHIR.IdentifierUse):
  value.value

define function ToString(value FHIR.StructureMapTargetListMode):
  value.value

define function ToString(value FHIR.TestReportParticipantType):
  value.value

define function ToString(value FHIR.BindingStrength):
  value.value

define function ToString(value FHIR.RequestPriority):
  value.value

define function ToString(value FHIR.ParticipantRequired):
  value.value

define function ToString(value FHIR.XPathUsageType):
  value.value

define function ToString(value FHIR.InstanceAvailability):
  value.value

define function ToString(value FHIR.id):
  value.value

define function ToString(value FHIR.FilterOperator):
  value.value

define function ToString(value FHIR.NamingSystemType):
  value.value

define function ToString(value FHIR.ContractResourceStatusCodes):
  value.value

define function ToString(value FHIR.validationType):
  value.value

define function ToString(value FHIR.ResearchSubjectStatus):
  value.value

define function ToString(value FHIR.StructureMapTransform):
  value.value

define function ToString(value FHIR.ResponseType):
  value.value

define function ToDecimal(value FHIR.decimal):
  value.value

define function ToString(value FHIR.AggregationMode):
  value.value

define function ToString(value FHIR.SystemRestfulInteraction):
  value.value

define function ToString(value FHIR.AdverseEventActuality):
  value.value

define function ToString(value FHIR.SubscriptionChannelType):
  value.value

define function ToString(value FHIR.AssertionDirectionType):
  value.value

define function ToString(value FHIR.canPushUpdates):
  value.value

define function ToString(value FHIR.CarePlanIntent):
  value.value

define function ToString(value FHIR.ConsentState):
  value.value

define function ToString(value FHIR.AllergyIntoleranceCriticality):
  value.value

define function ToString(value FHIR.PropertyRepresentation):
  value.value

define function ToString(value FHIR.TriggerType):
  value.value

define function ToString(value FHIR.CompositionStatus):
  value.value

define function ToString(value FHIR.AppointmentStatus):
  value.value

define function ToString(value FHIR.MessageSignificanceCategory):
  value.value

define function ToString(value FHIR.ListMode):
  value.value

define function ToString(value FHIR.ObservationStatus):
  value.value

define function ToString(value FHIR.ConsentScopeCodes):
  value.value

define function ToString(value FHIR.ResourceType):
  value.value

define function ToBoolean(value FHIR.boolean):
  value.value

define function ToString(value FHIR.StructureMapGroupTypeMode):
  value.value

define function ToString(value FHIR.SupplyRequestStatus):
  value.value

define function ToString(value FHIR.EncounterLocationStatus):
  value.value

define function ToString(value FHIR.CarePlanStatus):
  value.value

define function ToString(value FHIR.ConditionClinicalStatusCodes):
  value.value

define function ToString(value FHIR.ProcessOutcomeCodes):
  value.value

define function ToString(value FHIR.ConditionalDeleteStatus):
  value.value

define function ToString(value FHIR.NutritionOrderStatus):
  value.value

define function ToString(value FHIR.uri):
  value.value

define function ToString(value FHIR.Use):
  value.value

define function ToString(value FHIR.IdentityAssuranceLevel):
  value.value

define function ToString(value FHIR.DeviceMetricColor):
  value.value

define function ToTime(value FHIR.time):
  value.value

define function ToString(value FHIR.ConditionalReadStatus):
  value.value

define function ToString(value FHIR.ConditionVerificationStatus):
  value.value

define function ToString(value FHIR.AllergyIntoleranceSeverity):
  value.value

define function ToString(value FHIR.FinancialResourceStatusCodes):
  value.value

define function ToString(value FHIR.OperationKind):
  value.value

define function ToString(value FHIR.SubscriptionStatus):
  value.value

define function ToString(value FHIR.DocumentReferenceStatus):
  value.value

define function ToString(value FHIR.repositoryType):
  value.value

define function ToString(value FHIR.LocationStatus):
  value.value

define function ToString(value FHIR.NoteType):
  value.value

define function ToString(value FHIR.TestReportStatus):
  value.value

define function ToString(value FHIR.CodeSystemContentMode):
  value.value

define function ToString(value FHIR.FHIRDeviceStatus):
  value.value

define function ToString(value FHIR.ContactPointSystem):
  value.value

define function ToString(value FHIR.SlotStatus):
  value.value

define function ToString(value FHIR.PropertyType):
  value.value

define function ToString(value FHIR.TypeDerivationRule):
  value.value

define function ToString(value FHIR.GuidanceResponseStatus):
  value.value

define function ToString(value FHIR.RelatedArtifactType):
  value.value

define function ToString(value FHIR.oid):
  value.value

define function ToString(value FHIR.MediaStatus):
  value.value

define function ToString(value FHIR.CompartmentType):
  value.value

define function ToString(value FHIR.DeviceMetricCalibrationState):
  value.value

define function ToString(value FHIR.InvoicePriceComponentType):
  value.value

define function ToString(value FHIR.GroupType):
  value.value

define function ToString(value FHIR.ImmunizationEvaluationStatusCodes):
  value.value

define function ToString(value FHIR.ExampleScenarioActorType):
  value.value

define function ToString(value FHIR.HazardousDutyWork):
  value.value

define function ToString(value FHIR.ProvenanceEntityRole):
  value.value

define function ToString(value FHIR.ContractDataMeaning):
  value.value

define function ToString(value FHIR.SpecimenStatus):
  value.value

define function ToString(value FHIR.RestfulCapabilityMode):
  value.value

define function ToString(value FHIR.DetectedIssueSeverity):
  value.value

define function ToString(value FHIR.VisionEyes):
  value.value

define function ToString(value FHIR.ConsentDataMeaning):
  value.value

define function ToString(value FHIR.DocumentRelationshipType):
  value.value

define function ToString(value FHIR.AllergyIntoleranceClinicalStatus):
  value.value

define function ToString(value FHIR.TestReportResult):
  value.value

define function ToString(value FHIR.ConceptMapGroupUnmappedMode):
  value.value

define function ToDateTime(value FHIR.instant):
  value.value

define function ToDateTime(value FHIR.dateTime):
  value.value

define function ToDate(value FHIR.date):
  value.value

define function ToInteger(value FHIR.positiveInt):
  value.value

define function ToString(value FHIR.ClinicalImpressionStatus):
  value.value

define function ToString(value FHIR.NarrativeStatus):
  value.value

define function ToString(value FHIR.MeasmntPrinciple):
  value.value

define function ToString(value FHIR.EndpointStatus):
  value.value

define function ToString(value FHIR.GuidePageKind):
  value.value

define function ToString(value FHIR.GuideDependencyType):
  value.value

define function ToString(value FHIR.BiologicallyDerivedProductCategory):
  value.value

define function ToString(value FHIR.ResourceVersionPolicy):
  value.value

define function ToString(value FHIR.MedicationRequestStatus):
  value.value

define function ToString(value FHIR.MedicationAdministrationStatus):
  value.value

define function ToString(value FHIR.ActionCardinalityBehavior):
  value.value

define function ToString(value FHIR.MedicationRequestIntent):
  value.value

define function ToString(value FHIR.NamingSystemIdentifierType):
  value.value

define function ToString(value FHIR.ImmunizationStatusCodes):
  value.value

define function ToString(value FHIR.ConfidentialityClassification):
  value.value

define function ToString(value FHIR.need):
  value.value

define function ToString(value FHIR.HistoryOfEmploymentStatus):
  value.value

define function ToString(value FHIR.DiscriminatorType):
  value.value

define function ToString(value FHIR.StructureMapInputMode):
  value.value

define function ToString(value FHIR.LinkageType):
  value.value

define function ToString(value FHIR.ReferenceHandlingPolicy):
  value.value

define function ToString(value FHIR.MedicationStatus):
  value.value

define function ToString(value FHIR.ResearchStudyStatus):
  value.value

define function ToString(value FHIR.ExtensionContext):
  value.value

define function ToString(value FHIR.FHIRDefinedType):
  value.value

define function ToString(value FHIR.AuditEventOutcome):
  value.value

define function ToString(value FHIR.SpecimenContainedPreference):
  value.value

define function ToString(value FHIR.ActionRelationshipType):
  value.value

define function ToString(value FHIR.ConstraintSeverity):
  value.value

define function ToString(value FHIR.failureAction):
  value.value

define function ToString(value FHIR.EventCapabilityMode):
  value.value

define function ToString(value FHIR.CodeSearchSupport):
  value.value

define function ToString(value FHIR.UDIEntryType):
  value.value

define function ToString(value FHIR.UserSessionStatus):
  value.value

define function ToString(value FHIR.UserSessionStatusSource):
  value.value

define function ToString(value FHIR.DeviceMetricCategory):
  value.value

define function ToString(value FHIR.TestReportActionResult):
  value.value

define function ToString(value FHIR.CapabilityStatementKind):
  value.value

define function ToString(value FHIR.AllergyIntoleranceVerificationStatus):
  value.value

define function ToString(value FHIR.EventTiming):
  value.value

define function ToString(value FHIR.GoalStatus):
  value.value

define function ToString(value FHIR.SearchParamType):
  value.value

define function ToString(value FHIR.ActionGroupingBehavior):
  value.value

define function ToString(value FHIR.StructureMapModelMode):
  value.value

define function ToString(value FHIR.TaskStatus):
  value.value

define function ToString(value FHIR.BiologicallyDerivedProductStorageScale):
  value.value

define function ToString(value FHIR.GraphCompartmentRule):
  value.value

define function ToString(value FHIR.pushTypeAvailable):
  value.value

define function ToString(value FHIR.SlicingRules):
  value.value

define function ToString(value FHIR.ExplanationOfBenefitStatus):
  value.value

define function ToString(value FHIR.LinkType):
  value.value

define function ToString(value FHIR.ConceptMapEquivalence):
  value.value

define function ToString(value FHIR.FHIRAllTypes):
  value.value

define function ToString(value FHIR.AuditEventAction):
  value.value

define function ToString(value FHIR.SearchModifierCode):
  value.value

define function ToString(value FHIR.EventStatus):
  value.value

define function ToString(value FHIR.OperationParameterUse):
  value.value

define function ToString(value FHIR.ConsentProvisionType):
  value.value

define function ToString(value FHIR.ActionConditionKind):
  value.value

define function ToString(value FHIR.qualityType):
  value.value

define function ToString(value FHIR.AdministrativeGender):
  value.value

define function ToString(value FHIR.QuestionnaireItemType):
  value.value

define function ToString(value FHIR.DeviceMetricCalibrationType):
  value.value

define function ToString(value FHIR.code):
  value.value

define function ToString(value FHIR.ActionSelectionBehavior):
  value.value

define function ToString(value FHIR.SupplyDeliveryStatus):
  value.value

define function ToString(value FHIR.DiagnosticReportStatus):
  value.value

define function ToString(value FHIR.FlagStatus):
  value.value

define function ToString(value FHIR.UsualOccupation):
  value.value

define function ToString(value FHIR.ListStatus):
  value.value

define function ToBase64Binary(value FHIR.base64Binary):
  value.value

define function ToString(value FHIR.DeviceUseStatementStatus):
  value.value

define function ToString(value FHIR.AuditEventAgentNetworkType):
  value.value

define function ToString(value FHIR.ExpressionLanguage):
  value.value

define function ToString(value FHIR.AddressUse):
  value.value

define function ToString(value FHIR.ContactPointUse):
  value.value

define function ToString(value FHIR.DeviceMetricOperationalStatus):
  value.value

define function ToString(value FHIR.ContributorType):
  value.value

define function ToString(value FHIR.ReferenceVersionRules):
  value.value

define function ToString(value FHIR.MeasureReportStatus):
  value.value

define function ToString(value FHIR.SearchEntryMode):
  value.value

define function ToInteger(value FHIR.unsignedInt):
  value.value

define function ToString(value FHIR.NameUse):
  value.value

define function ToString(value FHIR.LocationMode):
  value.value

define function ToInteger(value FHIR.integer):
  value.value

define function ToString(value FHIR.FHIRSubstanceStatus):
  value.value

define function ToString(value FHIR.UnknownContentCode):
  value.value

define function ToString(value FHIR.HTTPVerb):
  value.value

define function ToString(value FHIR.EpisodeOfCareStatus):
  value.value

define function ToString(value FHIR.RemittanceOutcome):
  value.value

define function ToString(value FHIR.markdown):
  value.value

define function ToString(value FHIR.MedicationStatementStatus):
  value.value

define function ToString(value FHIR.QuantityComparator):
  value.value

define function ToString(value FHIR.MeasureReportType):
  value.value

define function ToString(value FHIR.ActionPrecheckBehavior):
  value.value

define function ToString(value FHIR.SampledDataDataType):
  value.value

define function ToString(value FHIR.CompositionAttestationMode):
  value.value

define function ToString(value FHIR.TypeRestfulInteraction):
  value.value

define function ToString(value FHIR.CodeSystemHierarchyMeaning):
  value.value

define function ToString(value FHIR.validationStatus):
  value.value

define function ToString(value FHIR.VisionBase):
  value.value

define function ToString(value FHIR.BundleType):
  value.value

define function ToString(value FHIR.SystemVersionProcessingMode):
  value.value