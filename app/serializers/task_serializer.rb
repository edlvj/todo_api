class TaskSerializer
  include FastJsonapi::ObjectSerializer
  attributes :id, :title, :done, :priority
  has_many :comments, serializer: :comment
end