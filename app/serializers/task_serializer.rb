class TaskSerializer
  include FastJsonapi::ObjectSerializer
  attributes :id, :title, :done, :priority, :deadline
  has_many :comments, serializer: :comment
end